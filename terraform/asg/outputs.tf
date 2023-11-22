output "target_group_arn" {
  description = "arn of the target group"
  value       = aws_lb_target_group.application.arn
}
