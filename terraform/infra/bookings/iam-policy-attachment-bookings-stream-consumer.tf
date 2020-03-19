resource "aws_iam_policy_attachment" "booking_stream_consumer_policy_attachment" {
  name       = "${var.environment}-booking-stream-consumer-policy-attachment"
  roles       = ["${aws_iam_role.bookings_stream_consumer_iam_role.name}"]
  policy_arn = "${aws_iam_policy.bookings_stream_consumer_policy.arn}"
}
