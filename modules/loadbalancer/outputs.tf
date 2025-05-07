output "target_group_arn" {
  description = "ARN of the target group"
  value       = aws_lb_target_group.main.arn
}

output "target_group_name" {
  description = "Name of the target group"
  value       = aws_lb_target_group.main.name
}

output "dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.main.dns_name
}

output "zone_id" {
  description = "Zone ID of the load balancer"
  value       = aws_lb.main.zone_id
}

output "https_listener_arn" {
  description = "ARN of the HTTPS listener"
  value       = aws_lb_listener.https.arn
}

output "load_balancer_arn" {
  description = "ARN of the load balancer"
  value       = aws_lb.main.arn
} 