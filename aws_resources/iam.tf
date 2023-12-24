resource "aws_iam_policy" "iam_for_lambda" {
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface",
          "kms:encrypt",
          "kms:decrypt",
        ]
        Effect = "Allow"
        Resource = "*"
      }
    ]
  })
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_role_for_lambda" {
  name = "iam_role_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy_attachment" "iam-lambda-attach" {
  name = "lambda-attachment"
  roles = [ aws_iam_role.iam_role_for_lambda.name  ]
  policy_arn = aws_iam_policy.iam_for_lambda.arn
}
