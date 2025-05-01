variable "environment" {
  description = "Environment (dev/staging)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the EC2 instance will be created"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the EC2 instance will be created"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID for the EC2 instance"
  type        = string
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
  default     = 20
}
