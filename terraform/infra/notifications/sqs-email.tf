resource "aws_sqs_queue" "email" {
  name = "${var.environment}-email-queue"
  redrive_policy = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.email_dql.arn}\",\"maxReceiveCount\":3}"
}

resource "aws_sqs_queue" "email_dql" {
  name = "${var.environment}-email-queue-dlq"
}

