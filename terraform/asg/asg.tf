resource "aws_launch_template" "application" {
  name                   = "application"
  image_id               = var.AMI_image_id
  key_name               = var.key_name
  vpc_security_group_ids = [var.ec2_security_group_id]

  user_data = var.user_data
}

resource "aws_lb_target_group" "application_http" {
  name     = "application"
  port     = 8000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    port                = 80
    interval            = 30
    protocol            = "HTTP"
    path                = "/health"
    matcher             = "200"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_autoscaling_group" "application" {
  name     = "application"
  min_size = 1
  max_size = 3

  health_check_type = "EC2"

  vpc_zone_identifier = var.ec2_subnets

  target_group_arns = [aws_lb_target_group.application_http.arn]

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.application.id
      }
      override {
        instance_type = "t3.micro"
      }
    }
  }
}

resource "aws_autoscaling_policy" "average" {
  name                   = "application"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.application.name

  estimated_instance_warmup = 300

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 40.0
  }
}

# Para testar o funcionamento do autoscaling group, descomenta a secao abaixo e comente aws_auto_scaling_policy average
# resource "aws_autoscaling_policy" "averagenetworkin" {
#   name                   = "application"
#   policy_type            = "TargetTrackingScaling"
#   autoscaling_group_name = aws_autoscaling_group.application.name

#   estimated_instance_warmup = 300

#   target_tracking_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ASGAverageNetworkIn"
#     }

#     target_value = 10000000.0
#   }
# }

