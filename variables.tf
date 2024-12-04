# AWS Region
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

# Global tags
variable "global_tags" {
  description = "A map of global tags to apply to all resources"
  type        = map(string)
}

# S3 Bucket Name
variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

# EC2 instance Name
variable "ec2_instance_name" {
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
