provider "aws" {
  region = "us-east-2"  # your desired region
  # credentials will be automatically loaded from ~/.aws/credentials
  # AKIAQ4NXP3NYTUIWXCW6
  # 9JwyBUBRJNEK5SbGFxy724NovWKYENODYds5FYx1
} 


# Provider configuration for dev
provider "aws" {
  alias  = "dev"
  region = "us-east-2"
  DEV_ACCOUNT_ID = 061051231089
  
  assume_role {
    role_arn = "arn:aws:iam::DEV_ACCOUNT_ID:role/terraform-role"
  }
}

# Provider configuration for staging
provider "aws" {
  alias  = "staging"
  region = "us-east-1"
  STAGING_ACCOUNT_ID = 061051231089
  
  assume_role {
    role_arn = "arn:aws:iam::STAGING_ACCOUNT_ID:role/terraform-role"
  }
} 