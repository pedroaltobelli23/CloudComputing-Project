# Inicializando VPC
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
}

# Inicializando subnets publicas e privadas
resource "aws_subnet" "public_subnet1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.cidr_block_c1
  availability_zone       = var.availability_zone1
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.cidr_block_c2
  availability_zone       = var.availability_zone2
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_rds_subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_block_r1
  availability_zone = var.availability_zone1
}

resource "aws_subnet" "private_rds_subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_block_r2
  availability_zone = var.availability_zone2
}

# Inicializando internet gateway que sera usado pela subnet publica 
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}
