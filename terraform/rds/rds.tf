resource "aws_db_subnet_group" "subnet_group_db" {
  name = "db_subnet_group"
  subnet_ids = var.db_subnets
}

resource "aws_db_instance" "rdb" {
  allocated_storage = var.allocated_storage
  storage_type = "gp2"
  engine = var.engine
  engine_version = var.engineversion
  instance_class = "db.t2.micro"
  identifier = "mydb"
  username = var.username
  password = var.password

  vpc_security_group_ids = [var.rds_security_group_id]
  db_subnet_group_name = aws_db_subnet_group.subnet_group_db.name

  skip_final_snapshot = true
}