variable "cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "availability_zone1" {
  type = string
  default = "us-east-1a"
}

variable "availability_zone2" {
  type = string
  default = "us-east-1b"
}

variable "cidr_block_p1" {
  type = string
  default = "10.0.0.0/19"
}

variable "cidr_block_p2" {
  type = string
  default = "10.0.32.0/19"
}

variable "cidr_block_c1" {
  type = string
  default = "10.0.64.0/19"
}

variable "cidr_block_c2" {
  type = string
  default = "10.0.96.0/19"
}