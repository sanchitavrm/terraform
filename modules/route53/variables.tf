variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "create_hosted_zone" {
  description = "Whether to create a new hosted zone"
  type        = bool
  default     = false
}

variable "domain_name" {
  description = "Domain name for the hosted zone"
  type        = string
  default     = ""
}

variable "hosted_zone_id" {
  description = "ID of an existing hosted zone"
  type        = string
  default     = ""
}

variable "a_records" {
  description = "Map of A records to create"
  type = map(object({
    name    = string
    ttl     = number
    records = list(string)
  }))
  default = {}
}

variable "cname_records" {
  description = "Map of CNAME records to create"
  type = map(object({
    name   = string
    ttl    = number
    record = string
  }))
  default = {}
}

variable "mx_records" {
  description = "Map of MX records to create"
  type = map(object({
    name = string
    ttl  = number
    records = list(object({
      priority = number
      value    = string
    }))
  }))
  default = {}
}

variable "txt_records" {
  description = "Map of TXT records to create"
  type = map(object({
    name    = string
    ttl     = number
    records = list(string)
  }))
  default = {}
}

variable "alias_records" {
  description = "Map of alias records to create"
  type = map(object({
    name                   = string
    type                   = string
    alias_name            = string
    alias_zone_id         = string
    evaluate_target_health = bool
  }))
  default = {}
}

variable "health_checks" {
  description = "Map of health checks to create"
  type = map(object({
    fqdn              = string
    port              = number
    type              = string
    resource_path     = string
    failure_threshold = number
    request_interval  = number
  }))
  default = {}
} 