output "instance_id" {
  value = aws_instance.main.id
}

output "private_ip" {
  value = aws_instance.main.private_ip
}

output "public_ip" {
  value = aws_instance.main.public_ip
}

output "iam_role_name" {
  value = aws_iam_role.ec2_role.name
}

output "key_pair_name" {
  value = aws_key_pair.deployer.key_name
}
