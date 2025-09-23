output "athena_database_name" {
  value = aws_athena_database.this.name
}

output "athena_table_name" {
  value = aws_glue_catalog_table.this.name
}