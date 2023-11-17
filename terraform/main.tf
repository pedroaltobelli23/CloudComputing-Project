provider "aws" {
  region = local.region
}

locals {
  region = "us-east-1"
}

module "vpc" {
  source     = "./vpc"
  cidr_block = "10.0.0.0/16"

  cidr_block_c1 = "10.0.0.0/24"
  cidr_block_c2 = "10.0.2.0/24"
  cidr_block_c3 = "10.0.4.0/24"
  cidr_block_r1 = "10.0.8.0/24"
  cidr_block_r2 = "10.0.16.0/24"

  availability_zone1 = "us-east-1a"
  availability_zone2 = "us-east-1b"
}

module "route" {
  source = "./route"

  private_subnet1 = module.vpc.private_subnet1
  private_subnet2 = module.vpc.private_subnet2
  public_subnet1  = module.vpc.public_subnet1
  public_subnet2  = module.vpc.public_subnet2

  vpc_id = module.vpc.vpc_id

  internet_gateway_id = module.vpc.internet_gateway_id
  nat_gateway_id      = module.vpc.nat_gateway_id
}

module "asg" {
  source = "./asg"

  private_subnets = [module.vpc.private_subnet1, module.vpc.private_subnet2]
  vpc_id          = module.vpc.vpc_id
  AMI_image_id    = "ami-0884034875ab3fffd"
  key_name        = "teste"
}

module "alb" {
  source = "./alb"

  target_group_arn      = module.asg.target_group_arn
  alb_security_group_id = module.asg.alb_security_group_id
  alb_subnets           = [module.vpc.public_subnet1, module.vpc.public_subnet2]
}

module "rds" {
  source = "./rds"

  db_subnets           = [module.vpc.private_rds_subnet1, module.vpc.private_rds_subnet2]
  vpc_id               = module.vpc.vpc_id
  e2_security_group_id = module.asg.e2_security_group_id

  engine            = "mysql"
  username          = var.database_username
  password          = var.database_password
  allocated_storage = 3
}
