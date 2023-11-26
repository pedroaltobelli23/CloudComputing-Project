output "private_rds_subnet1" {
  description = "Id of private subnet 1"
  value       = aws_subnet.private_rds_subnet1.id
}

output "private_rds_subnet2" {
  description = "Id of private subnet 2"
  value       = aws_subnet.private_rds_subnet2.id
}

output "public_subnet1" {
  description = "Id of public subnet 1"
  value       = aws_subnet.public_subnet1.id
}

output "public_subnet2" {
  description = "Id of public subnet 2"
  value       = aws_subnet.public_subnet2.id
}

output "vpc_id" {
  description = "Id of the vpc"
  value       = aws_vpc.main.id
}

output "internet_gateway_id" {
  description = "Id of the gateway"
  value       = aws_internet_gateway.igw.id
}
