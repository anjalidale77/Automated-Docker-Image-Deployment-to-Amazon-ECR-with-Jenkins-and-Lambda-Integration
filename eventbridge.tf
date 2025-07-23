resource "aws_cloudwatch_event_rule" "ecr_push" {
  name        = "ecr-image-push-rule"
  description = "Triggers Lambda when an image is pushed to ECR"
  event_pattern = jsonencode({
    "source": ["aws.ecr"],
    "detail-type": ["ECR Image Action"],
    "detail": {
      "action-type": ["PUSH"]
    }
  })
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.notify_on_push.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ecr_push.arn
}

resource "aws_cloudwatch_event_target" "send_to_lambda" {
  rule      = aws_cloudwatch_event_rule.ecr_push.name
  target_id = "sendToLambda"
  arn       = aws_lambda_function.notify_on_push.arn
}
