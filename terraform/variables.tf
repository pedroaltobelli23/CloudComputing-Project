variable "database_username" {
  description = "username of the database"
  type = string
}

variable "database_password" {
  description = "password of the username"
  type = string
}

variable "database_name" {
  description = "name of the database"
  type = string
}

variable "key_pair_name" {
  description = "name of the instances keypair .pem file"
  type = string
}

variable "bucket_name" {
  description = "name of the s3 bucket"
  type = string
}