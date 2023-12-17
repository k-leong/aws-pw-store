# data "aws_iam_policy_document" "assume_role" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["lambda.amazonaws.com"]
#     }
#     actions = ["sts:AssumeRole"]
#   }
# }

# resource "aws_iam_role" "iam_for_lambda" {
#   name               = "iam_for_lambda"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }

module "vpc" {
  source = "../vpc"
}

module "iam" {
  source = "../iam"
}
data "archive_file" "create_zip" {
  type = "zip"
  source_file = "${path.module}/create.py"
  output_path = "${path.module}/create_function.zip"
}

resource "aws_lambda_function" "create-function" {
  filename = "${path.module}/create_function.zip"
  function_name = "create-function"
  role = module.iam.lambda_iam_arn
  vpc_config {
    security_group_ids = [module.vpc.sg_id]
    subnet_ids = [module.vpc.subnet_id]
  }

  handler = "create.lambda_handler"
  runtime = "python3.11"
}

data "archive_file" "retrieve_zip" {
  type = "zip"
  source_file = "${path.module}/retrieve.py"
  output_path = "${path.module}/retrieve_function.zip"
}

resource "aws_lambda_function" "retrieve-function" {
  filename = "${path.module}/retrieve_function.zip"
  function_name = "retrieve-function"
  role = module.iam.lambda_iam_arn
  vpc_config {
    security_group_ids = [module.vpc.sg_id]
    subnet_ids = [module.vpc.subnet_id]
  }

  handler = "retrieve.lambda_handler"
  runtime = "python3.11"
}