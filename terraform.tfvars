aws_region      = "eu-west-1"
s3_bucket_name  = "my-s3-bucket-04-12-2024"
ec2_instance_name = "my-ec2-instance-04-12-2024"
instance_type   = "t2.nano"
ami_id          = "ami-07355fe79b493752d" # Update with a valid AMI ID for your region
global_tags = {
  Environment = "Dev"
  Project     = "MyProject"
}
