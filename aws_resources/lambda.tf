# needs log group for cloudwatch logs

data "archive_file" "create_zip" {
  type        = "zip"
  source_file = "${path.module}/../create.py"
  output_path = "${path.module}/../create_function.zip"
}

resource "aws_lambda_function" "create-function" {
  filename      = "${path.module}/../create_function.zip"
  function_name = "create-function"
  role          = aws_iam_role.iam_role_for_lambda.arn
  # vpc_config {
  #   security_group_ids = [aws_security_group.sg.id]
  #   subnet_ids         = [aws_subnet.public_subnet.id]
  # }
  environment {
    variables = {
      kms_id = aws_kms_key.kms.id
    }
  }

  handler = "create.lambda_handler"
  runtime = "python3.11"
}

data "archive_file" "retrieve_zip" {
  type        = "zip"
  source_file = "${path.module}/../retrieve.py"
  output_path = "${path.module}/../retrieve_function.zip"
}

resource "aws_lambda_function" "retrieve-function" {
  filename      = "${path.module}/../retrieve_function.zip"
  function_name = "retrieve-function"
  role          = aws_iam_role.iam_role_for_lambda.arn
  # vpc_config {
  #   security_group_ids = [aws_security_group.sg.id]
  #   subnet_ids         = [aws_subnet.public_subnet.id]
  # }
  environment {
    variables = {
      kms_id = aws_kms_key.kms.id
    }
  }

  handler = "retrieve.lambda_handler"
  runtime = "python3.11"
}
