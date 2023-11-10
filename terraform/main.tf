provider "aws" {
  region = var.region
}


# Creating virtual private cloud
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "main"
  }
}

# Creating two private subnets
# The first one is for the EC2 Instances that will be available for a user of the application
# The second one is private
# Creating subnets is better to manage the ec2 instances and the Application Loab Balancer
resource "aws_subnet" "private_subnet_1" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.0.0/19"
  availability_zone = var.region
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.16.0/19"
  availability_zone = var.region
}

resource "aws_security_group" "ec2-sc" {
  name = "ec2-sc"
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ec2-sc"
  }
}

resource "aws_security_group" "alb-sc" {
  name = "alb-sc"
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "ec2-sc"
  } 
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
