provider "aws" {
  region = local.region
}

locals {
  region = "us-east-1"
}
#=========Arquitetura da nuvem=========#

# Creating Elastic IPs for the private subnets
resource "aws_eip" "nat" {
  count = 1
}

# Creating virtual private cloud
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  name = "vpc"
  cidr = "10.0.0.0/16"
  
  azs = ["us-east-1a"]

  private_subnets = ["10.0.32.0/19","10.0.64.0/19"]
  public_subnets = ["10.0.96.0/19"]

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true
  reuse_nat_ips = true
  external_nat_ip_ids = "${aws_eip.nat.*.id}"
}

#======================================#