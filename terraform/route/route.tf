resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }
}

resource "aws_route_table_association" "rds_association_1" {
  subnet_id      = var.private_rds_subnet1
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "rds_association_2" {
  subnet_id      = var.private_rds_subnet2
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "ec2_association_1" {
  subnet_id      = var.public_subnet1
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "ec2_association_2" {
  subnet_id      = var.public_subnet2
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "ec2_association_3" {
  subnet_id      = var.public_subnet3
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "ec2_association_4" {
  subnet_id      = var.public_subnet4
  route_table_id = aws_route_table.route_table.id
}