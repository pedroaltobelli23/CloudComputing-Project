resource "aws_security_group" "rds_sg" {
  name = "rds-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "ingress_rds_sg_traffic" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_sg.id
  source_security_group_id = var.e2_security_group_id
}

resource "aws_security_group_rule" "egress_alb_sg_traffic" {
  type                     = "egress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_sg.id
  source_security_group_id = var.e2_security_group_id
}

resource "aws_db_subnet_group" "subnet_group_db" {
  name = "db_subnet_group"
  subnet_ids = var.db_subnets
}

resource "aws_db_instance" "rdb" {
  allocated_storage = 10
  storage_type = "gp2"
  engine = var.engine
  engine_version = "5.7"
  instance_class = "db.t2.micro"
  identifier = "mydb"
  username = "dbuser"
  password = "dbpassword"

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.subnet_group_db.name

  skip_final_snapshot = true
}