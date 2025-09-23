variable "database_name" {
  type        = string
  description = "Name of the Glue database"
}

variable "database_description" {
  type        = string
  default     = "Database for AWS CUR data"
}

variable "table_name" {
  type        = string
  description = "Name of the Glue table"
}

variable "s3_location" {
  type        = string
  description = "S3 path where CUR data is stored"
}