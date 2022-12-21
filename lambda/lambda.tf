locals {
  id = "test-alex-tf"
}

resource "aws_iam_role" "test-alex-tf-lambda-role" {
  name = "${local.id}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["sts:AssumeRole"]
        Effect   = "Allow"
        Principal: {
          Service: "lambda.amazonaws.com"
        }
      }
    ]
  })
}


data "archive_file" "lambda_zip" {
  type = "zip"
  source_file = "app/lambda/main.py"
  output_path = "app/lambda/main.zip"
}


resource "aws_lambda_function" "test-alex-tf-lambda" {
  filename = "app/lambda/main.zip"
  function_name = "${local.id}-lambda-test"
  role = aws_iam_role.test-alex-tf-lambda-role.arn
  handler = "main.py"
  
  runtime = "python3.9"
}