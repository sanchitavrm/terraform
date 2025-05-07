# Hosted Zone
resource "aws_route53_zone" "main" {
  count = var.create_hosted_zone ? 1 : 0
  name  = var.domain_name

  tags = {
    Name        = "${var.environment}-hosted-zone"
    Environment = var.environment
  }
}

# A Record
resource "aws_route53_record" "a" {
  for_each = var.a_records

  zone_id = var.create_hosted_zone ? aws_route53_zone.main[0].zone_id : var.hosted_zone_id
  name    = each.value.name
  type    = "A"
  ttl     = each.value.ttl

  records = each.value.records
}

# CNAME Record
resource "aws_route53_record" "cname" {
  for_each = var.cname_records

  zone_id = var.create_hosted_zone ? aws_route53_zone.main[0].zone_id : var.hosted_zone_id
  name    = each.value.name
  type    = "CNAME"
  ttl     = each.value.ttl
  records = [each.value.record]
}

# MX Record
resource "aws_route53_record" "mx" {
  for_each = var.mx_records

  zone_id = var.create_hosted_zone ? aws_route53_zone.main[0].zone_id : var.hosted_zone_id
  name    = each.value.name
  type    = "MX"
  ttl     = each.value.ttl

  dynamic "records" {
    for_each = each.value.records
    content {
      priority = records.value.priority
      value    = records.value.value
    }
  }
}

# TXT Record
resource "aws_route53_record" "txt" {
  for_each = var.txt_records

  zone_id = var.create_hosted_zone ? aws_route53_zone.main[0].zone_id : var.hosted_zone_id
  name    = each.value.name
  type    = "TXT"
  ttl     = each.value.ttl
  records = each.value.records
}

# Alias Record
resource "aws_route53_record" "alias" {
  for_each = var.alias_records

  zone_id = var.create_hosted_zone ? aws_route53_zone.main[0].zone_id : var.hosted_zone_id
  name    = each.value.name
  type    = each.value.type

  alias {
    name                   = each.value.alias_name
    zone_id                = each.value.alias_zone_id
    evaluate_target_health = each.value.evaluate_target_health
  }
}

# Health Check
resource "aws_route53_health_check" "main" {
  for_each = var.health_checks

  fqdn              = each.value.fqdn
  port              = each.value.port
  type              = each.value.type
  resource_path     = each.value.resource_path
  failure_threshold = each.value.failure_threshold
  request_interval  = each.value.request_interval

  tags = {
    Name        = "${var.environment}-health-check-${each.key}"
    Environment = var.environment
  }
} 