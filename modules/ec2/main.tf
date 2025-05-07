# Random suffix for unique names
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

# IAM Role
resource "aws_iam_role" "ec2_role" {
  name = "${var.environment}-ec2-role-${random_string.suffix.result}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "${var.environment}-ec2-role"
    Environment = var.environment
  }
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.environment}-ec2-profile-${random_string.suffix.result}"
  role = aws_iam_role.ec2_role.name
}

# Example IAM Policy - S3 Read Access
resource "aws_iam_role_policy" "s3_read_policy" {
  name = "${var.environment}-s3-read-policy-${random_string.suffix.result}"
  role = aws_iam_role.ec2_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:Get*",
          "s3:List*"
        ]
        Resource = [
          "arn:aws:s3:::${var.environment}-bucket/*",
          "arn:aws:s3:::${var.environment}-bucket"
        ]
      }
    ]
  })
}

# Key Pair
resource "aws_key_pair" "deployer" {
  key_name   = "${var.environment}-deployer-key-${random_string.suffix.result}"
  public_key = var.ssh_public_key

  tags = {
    Name        = "${var.environment}-deployer-key"
    Environment = var.environment
  }
}

# EC2 Instance
resource "aws_instance" "main" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  vpc_security_group_ids = [var.security_group_id]
  key_name              = aws_key_pair.deployer.key_name
  iam_instance_profile  = aws_iam_instance_profile.ec2_profile.name

  user_data = base64encode(templatefile("${path.module}/user-data.sh", {
    environment = var.environment
    hostname    = "${var.environment}-server"
  }))

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name        = "${var.environment}-server"
    Environment = var.environment
  }
}
