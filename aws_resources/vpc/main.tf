resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public_subnet1" {
  cidr_block        = "10.0.0.0/20"
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-west-1b"
  tags = {
    Name = "public 1"
  }
}

resource "aws_subnet" "private_subnet1" {
  cidr_block        = "10.0.128.0/20"
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-west-1b"
  tags = {
    Name = "private 1"
  }
}

resource "aws_subnet" "public_subnet2" {
  cidr_block        = "10.0.16.0/20"
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-west-1c"
  tags = {
    Name = "public 2"
  }
}

resource "aws_subnet" "private_subnet2" {
  cidr_block        = "10.0.144.0/20"
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-west-1c"
  tags = {
    Name = "private 2"
  }
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.us-west-1.dynamodb"
  tags = {
    Name = "dynamodb endpoint"
  }
}

resource "aws_vpc_endpoint" "kms" {
  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.us-west-1.kms"
  subnet_ids        = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]
  tags = {
    Name = "kms endpoint"
  }
}
