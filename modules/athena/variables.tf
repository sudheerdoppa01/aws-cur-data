variable "database_name" {
  type        = string
  description = "Name of the Athena database"
}

variable "table_name" {
  type        = string
  description = "Name of the Athena table"
}

variable "output_bucket" {
  type        = string
  description = "S3 bucket for Athena query results and CUR data"
}

variable "s3_location" {
  type        = string
  description = "S3 prefix path where CUR data is stored"
}