output "private_subnets" {
  value = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]
}

output "public_subnets" {
  value = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "ddb_endpoint" {
  value = aws_vpc_endpoint.dynamodb.id
}

output "kms_endpoint" {
  value = aws_vpc_endpoint.kms.id
}