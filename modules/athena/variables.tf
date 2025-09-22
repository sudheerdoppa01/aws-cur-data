variable "environment" {
  type        = string
  description = "Deployment environment (dev, staging, prod)"
}

variable "database_name_prefix" {
  type        = string
  description = "Prefix for Athena database name"
  default     = "cur_db"
}

variable "bucket_name" {
  type        = string
  description = "S3 bucket for CUR data and Athena query results"
}

variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}