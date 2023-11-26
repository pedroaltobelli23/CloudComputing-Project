variable "cidr_block" {
  type    = string
  description = "CIDR block da nuvem"
  default = "10.0.0.0/16"
}

variable "availability_zone1" {
  description = "Zona da regiao aws"
  type    = string
  default = "us-east-1a"
}

variable "availability_zone2" {
  description = "Zona da regiao aws"
  type    = string
  default = "us-east-1b"
}

variable "cidr_block_c1" {
  description = "subnet publica 1"
  type    = string
  default = "10.0.0.0/19"
}

variable "cidr_block_c2" {
  description = "subnet publica 2"
  type    = string
  default = "10.0.64.0/19"
}

variable "cidr_block_r1" {
  description = "subnet privada 1"
  type    = string
  default = "10.0.64.0/19"
}

variable "cidr_block_r2" {
  description = "subnet privada 2"
  type    = string
  default = "10.0.96.0/19"
}
