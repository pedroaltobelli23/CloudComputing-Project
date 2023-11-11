provider "aws" {
  region = var.region
}

resource "aws_security_group" "ec2_sc" {
  name = "ec2_sc"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group" "alb_sc" {
  name = "alb_sc"
  vpc_id = aws_vpc.main.id
}

# Create rule for ec2 instances that allow traffic on port 8080
resource "aws_security_group_rule" "ingress_ec2_traffic" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ec2-sc.id
  source_security_group_id = aws_security_group.alb-sc.id
}

# Create rule for ec2 instances that allow check health on port 8081
resource "aws_security_group_rule" "ingress_ec2_health_check" {
  type                     = "ingress"
  from_port                = 8081
  to_port                  = 8081
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ec2-sc.id
  source_security_group_id = aws_security_group.alb-sc.id
}

# Create rule for alb that allow traffic on port 80
resource "aws_security_group_rule" "ingress_alb_http_traffic" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.alb-sc.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# Create rule for alb that allow traffic on port 443
resource "aws_security_group_rule" "ingress_alb_https_traffic" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.alb-sc.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# Create rule for alb that allow leaving traffic from port 8080
resource "aws_security_group_rule" "egress_alb_traffic" {
  type                     = "egress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.alb-eg2.id
  source_security_group_id = aws_security_group.ec2-eg2.id
}

# Create rule for alb that allow leaving traffic from port 8081
resource "aws_security_group_rule" "egress_alb_health_check" {
  type                     = "egress"
  from_port                = 8081
  to_port                  = 8081
  protocol                 = "tcp"
  security_group_id        = aws_security_group.alb-sc.id
  source_security_group_id = aws_security_group.ec2-sc.id
}

#Creating launch_template with aplication as IAM
resource "aws_launch_template" "app_temlate" {
  name = "app_template"
  image_id = "valor"
  key_name = "pedroapp"
  vpc_security_group_ids = [aws_security_group.ec2_sc.id]
}

resource "aws_lb_target_group" "target_group" {
  name     = "target_group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    enabled             = true
    port                = 8081
    interval            = 30
    protocol            = "HTTP"
    path                = "/healthcheck"
    matcher             = "200"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_autoscaling_group" "autoscaling_group" {
  name     = "autoscaling_group"
  min_size = 1
  max_size = 3

  health_check_type = "EC2"

  vpc_zone_identifier = [
    aws_subnet.private_subnet1.id,
    aws_subnet.private_subnet2.id
  ]

  target_group_arns = [aws_lb_target_group.target_group.arn]

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.app_temlate.id
      }
      override {
        instance_type = "t3.micro"
      }
    }
  }
}

resource "aws_autoscaling_policy" "autoscaling_policy" {
  name                   = "autoscaling_policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name

  estimated_instance_warmup = 300

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 25.0
  }
}

#Creating the load balancer
resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sc.id]

  subnets = [
    aws_subnet.private_subnet1.id,
    aws_subnet.private_subnet2.id
  ]
}

#Creating listener
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
