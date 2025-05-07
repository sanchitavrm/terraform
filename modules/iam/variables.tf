variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "role_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "assume_role_service" {
  description = "AWS service that can assume this role"
  type        = string
  default     = "ec2.amazonaws.com"
}

variable "policy_name" {
  description = "Name of the IAM policy"
  type        = string
}

variable "policy_description" {
  description = "Description of the IAM policy"
  type        = string
  default     = ""
}

variable "policy_document" {
  description = "JSON policy document"
  type        = string
}

variable "create_instance_profile" {
  description = "Whether to create an instance profile"
  type        = bool
  default     = false
}

variable "create_user" {
  description = "Whether to create an IAM user"
  type        = bool
  default     = false
}

variable "user_name" {
  description = "Name of the IAM user"
  type        = string
  default     = ""
}

variable "create_group" {
  description = "Whether to create an IAM group"
  type        = bool
  default     = false
}

variable "group_name" {
  description = "Name of the IAM group"
  type        = string
  default     = ""
} 