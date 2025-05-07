variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ECS cluster will be created"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ECS cluster"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security group IDs for the ECS service"
  type        = list(string)
}

variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = ""
}

variable "service_name" {
  description = "Name of the ECS service"
  type        = string
  default     = ""
}

variable "task_family" {
  description = "Family name for the task definition"
  type        = string
  default     = ""
}

variable "container_port" {
  description = "Port that the container exposes"
  type        = number
  default     = 80
}

variable "cpu" {
  description = "CPU units for the task"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Memory for the task in MB"
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Desired number of tasks"
  type        = number
  default     = 1
}

variable "max_count" {
  description = "Maximum number of tasks"
  type        = number
  default     = 4
}

variable "min_count" {
  description = "Minimum number of tasks"
  type        = number
  default     = 1
}

variable "target_group_arn" {
  description = "ARN of the target group for the service"
  type        = string
}

variable "container_definitions" {
  description = "Container definitions for the task"
  type        = string
}

variable "auto_scaling_group_arn" {
  description = "ARN of the Auto Scaling Group to use as capacity provider"
  type        = string
} 