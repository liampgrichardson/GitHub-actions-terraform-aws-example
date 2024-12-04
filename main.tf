# Define the provider
provider "aws" {
  region = var.aws_region
}

# TF state bucket
terraform {
  backend "s3" {
    bucket = "my-tfstate-bucket-001" # Replace with your S3 bucket name
    key    = "terraform.tfstate"
    region = "eu-west-1"             # Replace with your AWS region
  }
}

# S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.s3_bucket_name

  tags = merge(var.global_tags, {
    Name        = var.s3_bucket_name
  })
}

# EC2 Instance
resource "aws_instance" "my_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = merge(var.global_tags, {
    Name = var.ec2_instance_name
  })
}
