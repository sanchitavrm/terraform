# Networking Module
module "networking" {
  source = "./modules/networking"

  environment          = var.environment
  vpc_cidr            = var.vpc_cidr
  public_subnets_cidr = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  availability_zones  = var.availability_zones
}

# IAM Module
module "iam" {
  source = "./modules/iam"

  environment         = var.environment
  role_name          = "ec2-role"
  assume_role_service = "ec2.amazonaws.com"
  policy_name        = "ec2-policy"
  policy_description = "Policy for EC2 instances"
  policy_document    = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeTags",
          "ec2:DescribeVolumes",
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
  create_instance_profile = true
}

# EC2 Module
module "ec2" {
  source = "./modules/ec2"
  
  environment       = var.environment
  vpc_id           = module.networking.vpc_id
  subnet_id        = module.networking.public_subnets_ids[0]
  security_group_id = module.networking.security_group_id
  
  instance_type    = var.instance_type
  ami_id           = var.ami_id
  ssh_public_key   = var.ssh_public_key
  root_volume_size = var.root_volume_size
}

# Load Balancer Module
module "loadbalancer" {
  source = "./modules/loadbalancer"

  environment     = var.environment
  internal        = false
  security_group_id = module.networking.security_group_id
  subnet_ids      = module.networking.public_subnets_ids
  vpc_id          = module.networking.vpc_id
  certificate_arn = var.certificate_arn

  enable_access_logs = true
  access_logs_bucket = var.access_logs_bucket
  access_logs_prefix = var.access_logs_prefix

  health_check_path = "/health"
  health_check_port = "80"
}

# Auto Scaling Module
module "autoscaling" {
  source = "./modules/autoscaling"

  environment          = var.environment
  ami_id              = var.ami_id
  instance_type       = var.instance_type
  security_group_id   = module.networking.security_group_id
  subnet_ids          = module.networking.private_subnets_ids
  iam_instance_profile = module.iam.instance_profile_name
  associate_public_ip = false
  root_volume_size    = var.root_volume_size
  desired_capacity    = var.asg_desired_capacity
  max_size           = var.asg_max_size
  min_size           = var.asg_min_size
  target_group_arns   = [module.loadbalancer.target_group_arn]
}

# ECS Module
module "ecs" {
  source = "./modules/ecs"

  environment     = var.environment
  vpc_id         = module.networking.vpc_id
  subnet_ids     = module.networking.private_subnets_ids
  security_group_id = module.networking.security_group_id

  cluster_name   = "${var.environment}-ecs-cluster"
  service_name   = "${var.environment}-ecs-service"
  task_family    = "${var.environment}-task"
  container_port = 80
  cpu            = 256
  memory         = 512

  desired_count  = var.ecs_desired_count
  max_count      = var.ecs_max_count
  min_count      = var.ecs_min_count

  target_group_arn = module.loadbalancer.target_group_arn
}

# EKS Module
module "eks" {
  source = "./modules/eks"

  environment     = var.environment
  cluster_name    = "${var.environment}-eks-cluster"
  cluster_version = var.eks_cluster_version

  vpc_id         = module.networking.vpc_id
  subnet_ids     = module.networking.private_subnets_ids
  security_group_id = module.networking.security_group_id

  node_groups = {
    general = {
      desired_size = var.eks_node_desired_size
      max_size     = var.eks_node_max_size
      min_size     = var.eks_node_min_size
      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
    }
  }

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}

# Route 53 Module
module "route53" {
  source = "./modules/route53"

  environment        = var.environment
  create_hosted_zone = var.create_hosted_zone
  domain_name        = var.domain_name
  hosted_zone_id     = var.hosted_zone_id

  a_records = {
    "app" = {
      name    = "app.${var.domain_name}"
      ttl     = 300
      records = [module.loadbalancer.dns_name]
    }
  }

  health_checks = {
    "app-health" = {
      fqdn              = "app.${var.domain_name}"
      port              = 80
      type              = "HTTP"
      resource_path     = "/health"
      failure_threshold = 3
      request_interval  = 30
    }
  }
} 