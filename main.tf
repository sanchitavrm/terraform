module "networking" {
  source = "./modules/networking"

  environment          = var.environment
  vpc_cidr            = var.vpc_cidr
  public_subnets_cidr = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  availability_zones  = var.availability_zones
}

# Your EC2 module can now reference the networking outputs
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