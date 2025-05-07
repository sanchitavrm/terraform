variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "auto_scaling_group_arn" {
  description = "ARN of the Auto Scaling Group to use as capacity provider"
  type        = string
} 