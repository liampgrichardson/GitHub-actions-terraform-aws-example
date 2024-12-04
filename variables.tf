# AWS Region
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

# S3 Bucket Name
variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

# EC2 Instance Type
variable "instance_type" {
  description = "The instance type for EC2"
  type        = string
  default     = "t2.nano"
}

# AMI ID
variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}
