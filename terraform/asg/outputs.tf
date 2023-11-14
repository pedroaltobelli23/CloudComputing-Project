output "target_group_arn" {
  description = "arn of the target group"
  value = aws_lb_target_group.application.arn
}

output "alb_security_group_id" {
  description = "id of security group created for the alb"
  value = aws_security_group.alb_sg.id
}