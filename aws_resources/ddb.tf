resource "aws_dynamodb_table" "dynamodb-table" {
  name                        = "PasswordStore"
  billing_mode                = "PAY_PER_REQUEST"
  hash_key                    = "PassKey"
  deletion_protection_enabled = true
  attribute {
    name = "PassKey"
    type = "S"
  }

  tags = {
    Name = "PasswordStore"
  }
}

resource "aws_dynamodb_table" "dynamodb-table-2" {
  name                        = "SaltStore"
  billing_mode                = "PAY_PER_REQUEST"
  hash_key                    = "SaltKey"
  deletion_protection_enabled = true
  attribute {
    name = "SaltKey"
    type = "S"
  }

  tags = {
    Name = "SaltStore"
  }
}