output "private_rds_subnet1" {
  description = "Id of public subnet 1"
  value       = aws_subnet.private_rds_subnet1.id
}

output "private_rds_subnet2" {
  description = "Id of public subnet 2"
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

output "public_subnet3" {
  description = "Id of public subnet 3"
  value       = aws_subnet.public_subnet3.id
}

output "public_subnet4" {
  description = "Id of public subnet 4"
  value       = aws_subnet.public_subnet4.id
}

output "vpc_id" {
  description = "Id of the vpc"
  value       = aws_vpc.main.id
}

output "internet_gateway_id" {
  description = "Id of the gateway"
  value       = aws_internet_gateway.igw.id
}

output "nat_gateway_id" {
  description = "Id of the gateway"
  value       = aws_nat_gateway.private_nat.id
}
