output "instance_profile_name" {
  description = "Name of the IAM instance profile"
  value       = var.create_instance_profile ? aws_iam_instance_profile.main[0].name : ""
}

output "role_arn" {
  description = "ARN of the IAM role"
  value       = aws_iam_role.main.arn
}

output "role_name" {
  description = "Name of the IAM role"
  value       = aws_iam_role.main.name
}

output "policy_arn" {
  description = "ARN of the IAM policy"
  value       = aws_iam_policy.main.arn
} 