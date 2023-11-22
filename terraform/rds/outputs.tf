output "database_endpoint" {
  description = "Endpoint of the rds"
  value       = aws_db_instance.rdb.address
}
