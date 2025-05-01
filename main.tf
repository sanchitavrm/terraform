module "vpc" {
  source = "./modules/vpc"
  providers = {
    aws = aws[var.environment]
  }
  # ... other configuration ...
}

module "ec2" {
  source = "./modules/ec2"
  providers = {
    aws = aws[var.environment]
  }
  # ... other configuration ...
} 