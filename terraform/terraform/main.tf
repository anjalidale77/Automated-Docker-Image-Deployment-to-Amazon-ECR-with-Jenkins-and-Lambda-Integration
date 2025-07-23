provider "aws" {
  region = "us-east-1"
}

resource "aws_ecr_repository" "myapp_repo" {
  name = "myapp-repo"
}


resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_lambda_function" "notify_on_push" {
  filename         = "lambda_function_payload.zip"
  function_name    = "NotifyOnImagePush"
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = filebase64sha256("lambda_function_payload.zip")
}
