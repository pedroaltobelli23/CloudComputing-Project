resource "aws_s3_bucket" "bucket_terraform_state" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket_terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption_conf" {
  bucket = aws_s3_bucket.bucket_terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_object" "bucket_terraform_state" {
  bucket = aws_s3_bucket.bucket_terraform_state.id
  key = "terraform-state"
  source = "terraform.tfstate"
}
