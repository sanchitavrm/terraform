variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "ami_id" {
  description = "ID of the AMI to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "Type of instance to launch"
  type        = string
  default     = "t3.micro"
}

variable "security_group_id" {
  description = "Security group ID for the instances"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the Auto Scaling Group"
  type        = list(string)
}

variable "iam_instance_profile" {
  description = "IAM instance profile name"
  type        = string
}

variable "associate_public_ip" {
  description = "Whether to associate public IP to the instances"
  type        = bool
  default     = false
}

variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 20
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
  type        = number
  default     = 4
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "target_group_arns" {
  description = "List of target group ARNs for the Auto Scaling Group"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Additional tags for the Auto Scaling Group"
  type        = map(string)
  default     = {}
}

variable "scale_up_adjustment" {
  description = "Number of instances to add when scaling up"
  type        = number
  default     = 1
}

variable "scale_down_adjustment" {
  description = "Number of instances to remove when scaling down"
  type        = number
  default     = -1
}

variable "scale_up_cooldown" {
  description = "Cooldown period in seconds after scaling up"
  type        = number
  default     = 300
}

variable "scale_down_cooldown" {
  description = "Cooldown period in seconds after scaling down"
  type        = number
  default     = 300
}

variable "cpu_threshold_high" {
  description = "CPU threshold percentage for scaling up"
  type        = number
  default     = 80
}

variable "cpu_threshold_low" {
  description = "CPU threshold percentage for scaling down"
  type        = number
  default     = 20
} 