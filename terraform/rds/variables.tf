variable "db_subnets" {
  description = "List of IDs from private subnets used by the db"
  type        = list(string)
  default     = ["subnet-123456789", "subnet-123456789"]
}

variable "rds_security_group_id" {
  description = "id of security group created for the rds"
  default     = "sg-123456789"
}

variable "engine" {
  description = "engine used in the database"
  default     = "mysql"
}

variable "engineversion" {
  description = "engine used in the database"
  default     = "5.7"
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
