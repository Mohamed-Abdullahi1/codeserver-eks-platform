variable "bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}