# Inicializando VPC
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
}

# Inicializando internet gateway que sera usado pela subnet publica 
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

# Inicializando subnets publicas e privadas
resource "aws_subnet" "private_subnet1" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.cidr_block_p1
  availability_zone = var.availability_zone1
}

resource "aws_subnet" "private_subnet2" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.cidr_block_p2
  availability_zone = var.availability_zone2

}

resource "aws_subnet" "public_subnet1" {
  vpc_id = aws_vpc.main.id  
  cidr_block = var.cidr_block_c1
  availability_zone = var.availability_zone1
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet2" {
  vpc_id = aws_vpc.main.id  
  cidr_block = var.cidr_block_c2
  availability_zone = var.availability_zone2
  map_public_ip_on_launch = true
}

# Inicializando nat que sera usada pela subnet privada
resource "aws_eip" "private_nat" {
}

resource "aws_nat_gateway" "private_nat" {
  allocation_id = aws_eip.private_nat.id
  subnet_id = aws_subnet.public_subnet1.id

  depends_on = [ aws_internet_gateway.igw ]
}