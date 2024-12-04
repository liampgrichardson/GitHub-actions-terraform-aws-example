aws_region      = "eu-west-1"
s3_bucket_name  = "my-unique-s3-bucket-name"
ec2_instance_name = "my-unique-ec2-instance-name"
instance_type   = "t2.nano"
ami_id          = "ami-07355fe79b493752d" # Update with a valid AMI ID for your region
global_tags = {
  Environment = "Dev"
  Project     = "MyProject"
}