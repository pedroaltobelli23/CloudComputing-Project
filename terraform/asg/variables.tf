variable "private_subnets" {
  description = "List of IDs from private subnets"
  type = list(string)
  default = [ "subnet-123456789","subnet-123456789" ]
}

variable "vpc_id" {
  description = "ID of the vpc main"
  default = "vpc-123456789"
}

variable "AMI_image_id" {
  description = "Id of the AMI image"
  default = "iam-123456789"
}

variable "key_name" {
  description = "Name of Key Pair"
  default = "name"
}