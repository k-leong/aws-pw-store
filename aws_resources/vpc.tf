# need to add route tables

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

# resource "aws_security_group" "sg" {
#   name   = "sg"
#   vpc_id = aws_vpc.main.id

#   ingress {
#     description = ""
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

resource "aws_route_table" "private1" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private1 rt"
  }
}

resource "aws_route_table" "private2" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private2 rt"
  }
}

resource "aws_vpc_endpoint_route_table_association" "ddb_route" {
  route_table_id  = aws_route_table.private1.id
  vpc_endpoint_id = aws_vpc_endpoint.dynamodb.id
}

resource "aws_route_table_association" "ddb_private_route1" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private1.id
}

resource "aws_route_table_association" "ddb_private_route2" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private2.id
}

