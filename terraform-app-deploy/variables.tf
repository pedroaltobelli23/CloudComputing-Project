variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "s3 bucket name"
  type = string
  default = "backup-bucket"
}

variable "db_backend" {
  description = "Name of Dynamo db"
  type = string
  default = "db_backend"
}