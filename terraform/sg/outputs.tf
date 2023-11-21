output "alb_security_group_id" {
  description = "id of security group created for the alb"
  value = aws_security_group.alb_sg.id
}

output "ec2_security_group_id" {
  description = "id of security group created for the ec2"
  value = aws_security_group.ec2_sg.id
}

output "rds_security_group_id" {
  description = "id of security group created for the rds"
  value = aws_security_group.rds_sg.id
}

