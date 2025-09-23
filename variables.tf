variable "region" {
  default = "us-east-1"
}

variable "environment" {
  description = "Deployment environment (e.g. dev, prod)"
  type        = string
}