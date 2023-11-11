# resource "aws_s3_bucket" "bteste" {
#   bucket = var.bucket_name
# }

# resource "aws_s3_bucket_versioning" "enabled" {
#   bucket = aws_s3_bucket.bteste.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
#   bucket = aws_s3_bucket.bteste.id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

# resource "aws_s3_bucket_public_access_block" "public_access" {
#   bucket                  = aws_s3_bucket.bteste.id
#   block_public_acls       = true
#   restrict_public_buckets = true
#   block_public_policy     = true
#   ignore_public_acls      = true

# }

# resource "aws_dynamodb_table" "db_backend" {
#   name = var.db_backend
#   read_capacity = 1
#   write_capacity = 1
#   hash_key = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }

# }