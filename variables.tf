variable "environment" {
  description = "Environment (dev/staging)"
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

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "ssh_public_key" {
  description = "Public SSH key for EC2 instance access"
  type        = string
}

variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
}

# Other variables... 