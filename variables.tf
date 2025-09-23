variable "environment" {
  type        = string
  description = "Deployment environment (e.g., dev, prod)"
}

variable "region" {
  type        = string
  description = "AWS region to deploy resources"
}