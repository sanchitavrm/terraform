# Provider configuration for dev
provider "aws" {
  alias  = "dev"
  region = "us-east-2"
  
  assume_role {
    role_arn = "arn:aws:iam::DEV_ACCOUNT_ID:role/terraform-role"
  }
}

# Provider configuration for staging
provider "aws" {
  alias  = "staging"
  region = "us-east-2"
  
  assume_role {
    role_arn = "arn:aws:iam::STAGING_ACCOUNT_ID:role/terraform-role"
  }
} 