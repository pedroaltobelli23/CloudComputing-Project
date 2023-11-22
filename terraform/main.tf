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
  cidr_block_c4 = "10.0.8.0/24"
  cidr_block_r1 = "10.0.16.0/24"
  cidr_block_r2 = "10.0.32.0/24"

  availability_zone1 = "us-east-1a"
  availability_zone2 = "us-east-1b"
}

module "route" {
  source = "./route"

  public_subnet1 = module.vpc.public_subnet1
  public_subnet2 = module.vpc.public_subnet2
  public_subnet3 = module.vpc.public_subnet3
  public_subnet4 = module.vpc.public_subnet4

  private_rds_subnet1 = module.vpc.private_rds_subnet1
  private_rds_subnet2 = module.vpc.private_rds_subnet2

  vpc_id = module.vpc.vpc_id

  internet_gateway_id = module.vpc.internet_gateway_id
}

module "sg" {
  source = "./sg"
  vpc_id = module.vpc.vpc_id
}

module "asg" {
  source = "./asg"

  ec2_subnets           = [module.vpc.public_subnet2, module.vpc.public_subnet3]
  vpc_id                = module.vpc.vpc_id
  AMI_image_id          = "ami-0884034875ab3fffd"
  key_name              = var.key_pair_name
  user_data             = base64encode(templatefile("scripts/install.sh", { var1 = module.rds.database_endpoint, var2 = var.database_name, var3 = var.database_password, var4 = var.database_username, var5 = module.alb.alb_dns }))
  ec2_security_group_id = module.sg.ec2_security_group_id
}

module "alb" {
  source = "./alb"

  target_group_arn      = module.asg.target_group_http_arn
  alb_security_group_id = module.sg.alb_security_group_id
  alb_subnets           = [module.vpc.public_subnet2, module.vpc.public_subnet3]
}

module "rds" {
  source = "./rds"

  db_subnets            = [module.vpc.private_rds_subnet1, module.vpc.private_rds_subnet2]
  rds_security_group_id = module.sg.rds_security_group_id

  engine            = "mysql"
  engineversion     = "8.0"
  username          = var.database_username
  password          = var.database_password
  allocated_storage = 10
}

resource "random_pet" "example" {
  length    = 8
  separator = ""
}

module "s3" {
  source = "./s3"
  bucket_name = "${var.bucket_name}-${replace(base64encode(sha256(random_pet.example.id)), "/[^0-9]/", "")}"
}