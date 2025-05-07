# IAM Role
resource "aws_iam_role" "main" {
  name = "${var.environment}-${var.role_name}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = var.assume_role_service
        }
      }
    ]
  })

  tags = {
    Name        = "${var.environment}-${var.role_name}"
    Environment = var.environment
  }
}

# IAM Policy
resource "aws_iam_policy" "main" {
  name        = "${var.environment}-${var.policy_name}"
  description = var.policy_description
  policy      = var.policy_document

  tags = {
    Name        = "${var.environment}-${var.policy_name}"
    Environment = var.environment
  }
}

# IAM Role Policy Attachment
resource "aws_iam_role_policy_attachment" "main" {
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.main.arn
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "main" {
  count = var.create_instance_profile ? 1 : 0
  name  = "${var.environment}-${var.role_name}-profile"
  role  = aws_iam_role.main.name

  tags = {
    Name        = "${var.environment}-${var.role_name}-profile"
    Environment = var.environment
  }
}

# IAM User
resource "aws_iam_user" "main" {
  count = var.create_user ? 1 : 0
  name  = "${var.environment}-${var.user_name}"

  tags = {
    Name        = "${var.environment}-${var.user_name}"
    Environment = var.environment
  }
}

# IAM User Policy Attachment
resource "aws_iam_user_policy_attachment" "main" {
  count      = var.create_user ? 1 : 0
  user       = aws_iam_user.main[0].name
  policy_arn = aws_iam_policy.main.arn
}

# IAM Group
resource "aws_iam_group" "main" {
  count = var.create_group ? 1 : 0
  name  = "${var.environment}-${var.group_name}"
}

# IAM Group Policy Attachment
resource "aws_iam_group_policy_attachment" "main" {
  count      = var.create_group ? 1 : 0
  group      = aws_iam_group.main[0].name
  policy_arn = aws_iam_policy.main.arn
}

# IAM Group Membership
resource "aws_iam_user_group_membership" "main" {
  count  = var.create_user && var.create_group ? 1 : 0
  user   = aws_iam_user.main[0].name
  groups = [aws_iam_group.main[0].name]
} 