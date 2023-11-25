resource "aws_lb" "application" {
  name               = "application"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group_id]

  subnets = var.alb_subnets
}

resource "aws_lb_listener" "application_http" {
  load_balancer_arn = aws_lb.application.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }
}