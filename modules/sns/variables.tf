variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "topic_name" {
  description = "Name of the SNS topic"
  type        = string
}

variable "display_name" {
  description = "Display name for the SNS topic"
  type        = string
  default     = ""
}

variable "kms_key_id" {
  description = "KMS key ID for SNS topic encryption"
  type        = string
  default     = null
}

variable "topic_policy" {
  description = "Custom policy for the SNS topic"
  type        = string
  default     = null
}

variable "subscriptions" {
  description = "Map of SNS topic subscriptions"
  type = map(object({
    protocol            = string
    endpoint            = string
    filter_policy       = optional(string)
    raw_message_delivery = optional(bool)
  }))
  default = {}
}

variable "enable_cloudwatch_alarm" {
  description = "Whether to enable CloudWatch alarm for the SNS topic"
  type        = bool
  default     = false
}

variable "alarm_actions" {
  description = "List of ARNs to notify when the alarm is triggered"
  type        = list(string)
  default     = []
} 