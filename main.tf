# Define the provider
provider "aws" {
  region = var.aws_region
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
