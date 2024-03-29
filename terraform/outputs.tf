output "alb_dns" {
  description = "dns of the load balancer"
  value       = module.alb.alb_dns
}

output "vpc_id" {
  description = "vpc id"
  value       = module.vpc.vpc_id
}

output "database_endpoint" {
  description = "database endpoint"
  value       = module.rds.database_endpoint
}

output "s3_bucket_arn" {
  value       = module.s3.s3_bucket_arn
  description = "The ARN of the S3 bucket"
}
