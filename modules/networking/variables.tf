variable "environment" {
  description = "The environment (dev/staging)"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnets_cidr" {
  description = "The CIDR block for the public subnet"
  type        = list(string)
}

variable "private_subnets_cidr" {
  description = "The CIDR block for the private subnet"
  type        = list(string)
}

variable "availability_zones" {
  description = "The az that the resources will be launched"
  type        = list(string)
} 