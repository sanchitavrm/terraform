# SNS Topic
resource "aws_sns_topic" "main" {
  name = "${var.environment}-${var.topic_name}"
  display_name = var.display_name

  kms_master_key_id = var.kms_key_id

  policy = var.topic_policy != null ? var.topic_policy : jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "s3.amazonaws.com"
        }
        Action = [
          "SNS:Publish"
        ]
        Resource = "arn:aws:sns:*:*:${var.environment}-${var.topic_name}"
        Condition = {
          ArnLike = {
            "aws:SourceArn": "arn:aws:s3:::${var.environment}-bucket"
          }
        }
      }
    ]
  })

  tags = {
    Name        = "${var.environment}-${var.topic_name}"
    Environment = var.environment
  }
}

# SNS Topic Policy
resource "aws_sns_topic_policy" "main" {
  count = var.topic_policy != null ? 1 : 0

  arn    = aws_sns_topic.main.arn
  policy = var.topic_policy
}

# SNS Topic Subscriptions
resource "aws_sns_topic_subscription" "main" {
  for_each = var.subscriptions

  topic_arn = aws_sns_topic.main.arn
  protocol  = each.value.protocol
  endpoint  = each.value.endpoint

  filter_policy = each.value.filter_policy
  raw_message_delivery = each.value.raw_message_delivery
}

# CloudWatch Alarm for SNS Topic
resource "aws_cloudwatch_metric_alarm" "sns_alarm" {
  count = var.enable_cloudwatch_alarm ? 1 : 0

  alarm_name          = "${var.environment}-${var.topic_name}-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "NumberOfNotificationsFailed"
  namespace           = "AWS/SNS"
  period             = 300
  statistic          = "Sum"
  threshold          = 0
  alarm_description  = "This metric monitors SNS topic delivery failures"
  alarm_actions      = var.alarm_actions

  dimensions = {
    TopicName = aws_sns_topic.main.name
  }

  tags = {
    Name        = "${var.environment}-${var.topic_name}-alarm"
    Environment = var.environment
  }
} 