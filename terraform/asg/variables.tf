variable "ec2_subnets" {
  description = "List of IDs from public subnets that will be used by ec2s"
  type        = list(string)
  default     = ["subnet-123456789", "subnet-123456789"]
}

variable "vpc_id" {
  description = "ID of the vpc main"
  default     = "vpc-123456789"
}

variable "AMI_image_id" {
  description = "Id of the AMI image"
  default     = "iam-123456789"
}

variable "key_name" {
  description = "Name of Key Pair"
  default     = "name"
}

variable "ec2_security_group_id" {
  description = "id of security group created for the ec2"
  default     = "sg-123456789"
}

variable "user_data" {
  description = "the user data"
}
