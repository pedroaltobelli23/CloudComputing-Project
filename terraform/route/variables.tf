variable "private_subnet1" {
  description = "ID of private subnet 1"
  default = "subnet-123456789"
}

variable "private_subnet2" {
  description = "ID of private subnet 2"
  default = "subnet-123456789"
}

variable "public_subnet1" {
  description = "ID of public subnet 1"
  default = "subnet-123456789"
}

variable "public_subnet2" {
  description = "ID of public subnet 2"
  default = "subnet-123456789"
}

variable "vpc_id" {
  description = "ID of the vpc main"
  default = "vpc-123456789"
}

variable "internet_gateway_id" {
  description = "Id of the internet gateway"
  default = "gtw-123456789"
}

variable "nat_gateway_id" {
  description = "Id of the nat gateway"
  default = "nat-123456789"
}