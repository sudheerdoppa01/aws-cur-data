provider "aws" {
  region = var.region
}

resource "aws_athena_database" "cur_db" {
  name   = "${var.database_name_prefix}_${var.environment}"
  bucket = var.bucket_name
}