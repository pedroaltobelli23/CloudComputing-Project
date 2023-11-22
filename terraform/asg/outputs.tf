output "target_group_http_arn" {
  description = "arn of the http target group"
  value       = aws_lb_target_group.application_http.arn
}
