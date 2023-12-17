resource "aws_vpc" "main" {
  cidr_block = "172.0.0.0/16"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public_subnet" {
  cidr_block = "172.20.0.0/25"
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "public"
  }
}

output "subnet_id" {
  value = aws_subnet.public_subnet.id
}

resource "aws_security_group" "sg" {
  name = "sg"
  vpc_id = aws_vpc.main.id

  ingress {
    description = ""
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "sg_id" {
  value = aws_security_group.sg.id
}