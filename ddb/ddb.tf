resource "aws_dynamodb_table" "dynamodb-table" {
  name = "PasswordStore"
  billing_mode = "PAY_PER_REQUEST"
  # read_capacity = 20
  # write_capacity = 10

  tags = {
    Name = "PasswordStore"
    Environment = "Dev"
  }
}

resource "aws_dynamodb_table" "dynamodb-table-2" {
  name = "SaltStore"
  billing_mode = "PAY_PER_REQUEST"

  tags = {
    Name = "SaltStore"
    Environment = "Dev"
  }
}