variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "internal" {
  description = "Whether the load balancer is internal"
  type        = bool
  default     = false
}

variable "security_group_id" {
  description = "Security group ID for the load balancer"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the load balancer"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for the load balancer"
  type        = string
}

variable "certificate_arn" {
  description = "ARN of the SSL certificate"
  type        = string
  default     = ""
}

variable "enable_access_logs" {
  description = "Whether to enable access logs"
  type        = bool
  default     = true
}

variable "access_logs_prefix" {
  description = "Prefix for access logs"
  type        = string
  default     = "alb-logs"
}

variable "enable_deletion_protection" {
  description = "Whether to enable deletion protection"
  type        = bool
  default     = false
}

variable "health_check_path" {
  description = "Path for health check"
  type        = string
  default     = "/"
}

variable "health_check_port" {
  description = "Port for health check"
  type        = string
  default     = "80"
}

variable "target_group_port" {
  description = "Port for target group"
  type        = number
  default     = 80
}

variable "target_group_protocol" {
  description = "Protocol for target group"
  type        = string
  default     = "HTTP"
}

variable "health_check_healthy_threshold" {
  description = "Healthy threshold for health check"
  type        = number
  default     = 2
}

variable "health_check_unhealthy_threshold" {
  description = "Unhealthy threshold for health check"
  type        = number
  default     = 10
}

variable "health_check_timeout" {
  description = "Timeout for health check"
  type        = number
  default     = 5
}

variable "health_check_interval" {
  description = "Interval for health check"
  type        = number
  default     = 30
}

variable "health_check_matcher" {
  description = "Matcher for health check"
  type        = string
  default     = "200"
}

variable "health_check_protocol" {
  description = "Protocol for health check"
  type        = string
  default     = "HTTP"
}

variable "enable_stickiness" {
  description = "Whether to enable stickiness"
  type        = bool
  default     = false
}

variable "stickiness_cookie_duration" {
  description = "Cookie duration for stickiness"
  type        = number
  default     = 86400
}

variable "ssl_policy" {
  description = "SSL policy for HTTPS listener"
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
}

variable "listener_rules" {
  description = "Map of listener rules"
  type = map(object({
    priority     = number
    host_header  = optional(string)
    path_pattern = optional(string)
  }))
  default = {}
} 