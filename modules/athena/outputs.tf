output "db_name" {
  value       = aws_athena_database.cur_db.name
  description = "Name of the Athena database"
}