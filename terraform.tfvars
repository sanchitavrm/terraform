environment = "dev"

# VPC and Networking
vpc_cidr             = "10.0.0.0/16"
public_subnets_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets_cidr = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones   = ["us-east-2a", "us-east-2b"]

# EC2 Configuration
instance_type    = "t2.micro"
ami_id           = "ami-0cb91c7de36eed2cb"  # Amazon Linux 2 AMI ID (us-east-1)
root_volume_size = 10
ssh_public_key   = "ssh-rsa AAAA..."  # Replace with your actual public SSH key

# Auto Scaling Configuration
asg_desired_capacity = 2
asg_max_size        = 4
asg_min_size        = 1

# Load Balancer Configuration
certificate_arn     = "arn:aws:acm:us-east-1:123456789012:certificate/xxxxx"  # Replace with your actual certificate ARN
access_logs_bucket  = "dev-my-alb-logs-bucket"
access_logs_prefix  = "alb-logs"

# Route 53 Configuration
create_hosted_zone = true
domain_name       = "devexample.com"  # Replace with your actual domain name
hosted_zone_id    = ""  # Leave empty if creating new hosted zone 