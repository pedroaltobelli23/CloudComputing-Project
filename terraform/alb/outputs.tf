output "alb_dns" {
  description = "dns of the load balancer"
  value = aws_lb.application.dns_name
}