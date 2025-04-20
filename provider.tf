provider "aws" {
  region = "us-east-2"  # your desired region
  # credentials will be automatically loaded from ~/.aws/credentials
  # AKIAQ4NXP3NYTUIWXCW6
  # 9JwyBUBRJNEK5SbGFxy724NovWKYENODYds5FYx1
} 

module "ec2" {
  source         = "./modules/ec2"
}

module "vpc" {
  source         = "./modules/vpc"
}