resource "aws_route_table" "private1" {
  vpc_id = var.vpc_id

  tags = {
    Name = "private1 rt"
  }
}

resource "aws_route_table" "private2" {
  vpc_id = var.vpc_id

  tags = {
    Name = "private2 rt"
  }
}

resource "aws_vpc_endpoint_route_table_association" "ddb_route" {
  route_table_id  = aws_route_table.private1.id
  vpc_endpoint_id = var.ddb_endpoint_id
}

resource "aws_route_table_association" "ddb_private_route1" {
  subnet_id      = var.private_subnet1
  route_table_id = aws_route_table.private1.id
}

resource "aws_route_table_association" "ddb_private_route2" {
  subnet_id      = var.private_subnet2
  route_table_id = aws_route_table.private2.id
}