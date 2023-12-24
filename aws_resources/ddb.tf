resource "aws_dynamodb_table" "dynamodb-table" {
  name = "PasswordStore"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "PassKey"
  attribute {
    name = "PassKey"
    type = "S"
  }

  tags = {
    Name = "PasswordStore"
    Environment = "Dev"
  }
}

resource "aws_dynamodb_table" "dynamodb-table-2" {
  name = "SaltStore"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "SaltKey"
  attribute {
    name = "SaltKey"
    type = "S"
  }

  tags = {
    Name = "SaltStore"
    Environment = "Dev"
  }
}