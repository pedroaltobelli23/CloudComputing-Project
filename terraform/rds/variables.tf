variable "db_subnets" {
  description = "List of IDs from private subnets used by the db"
  type        = list(string)
  default     = ["subnet-123456789", "subnet-123456789"]
}

variable "vpc_id" {
  description = "ID of the vpc main"
  default     = "vpc-123456789"
}

variable "ec2_security_group_id" {
  description = "id of security group created for the ec2"
  default     = "sg-123456789"
}

variable "engine" {
  description = "engine used in the database"
  default     = "mysql"
}

variable "username" {
  description = "database username"
  default     = "dbuser"
}

variable "password" {
  description = "database password"
  default     = "dbpassword"
}

variable "allocated_storage" {
  description = "storage capacity of the database"
  default     = 10
}
