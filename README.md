# AWS EC2, S3, and Terraform with GitHub Actions Starter Repository

This repository provides a starter setup for managing AWS EC2 instances and S3 buckets using Terraform. It also includes GitHub Actions workflows for deploying and destroying infrastructure with Terraform.

## Features
- **Terraform Infrastructure as Code (IaC)**: Automates the creation of EC2 instances and S3 buckets.
- **GitHub Actions CI/CD Pipelines**: Integrates Terraform with GitHub Actions to deploy and destroy resources.
- **Terraform Backend (S3)**: Stores the Terraform state file in an S3 bucket, allowing for safe, shared management of state.

## Prerequisites
Before using this repository, you need:
- **AWS Account**: To create EC2 instances and S3 buckets.
- **Terraform**: For managing AWS infrastructure.
- **GitHub Secrets**: Store AWS access keys securely in GitHub repository secrets.
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
  - `AWS_REGION`

## Setup

### Terraform Configuration

The Terraform configuration files (`main.tf`) define the AWS resources:
- **EC2 Instance**: A simple EC2 instance defined with variables such as AMI ID and instance type.
- **S3 Bucket**: A basic S3 bucket created with a specified name.
- **State Backend**: The Terraform state is stored in an S3 bucket (`my-tfstate-bucket-001`).

```hcl
provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "my-tfstate-bucket-001"
    key    = "terraform.tfstate"
    region = "eu-west-1"
  }
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.s3_bucket_name

  tags = merge(var.global_tags, {
    Name = var.s3_bucket_name
  })
}

resource "aws_instance" "my_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = merge(var.global_tags, {
    Name = var.ec2_instance_name
  })
}
```

### GitHub Actions Workflows

The repository includes two GitHub Actions workflows for Terraform:

#### 1. `Terraform Deploy` Workflow

This workflow is triggered manually and handles the deployment of resources:
- **Terraform Init**: Initializes the Terraform configuration.
- **Terraform Plan**: Generates an execution plan.
- **Terraform Apply**: Applies the configuration and creates the AWS resources.

```yaml
name: Terraform Deploy

on:
  workflow_dispatch:

jobs:
  terraform:
    runs-on: ubuntu-latest
    environment: aws
    env:
      AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
      AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
      AWS_DEFAULT_REGION: ${{ secrets.AWS_REGION }}

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Set up Terraform
        uses: hashicorp/setup-terraform@v2

      - name: Initialize Terraform
        run: terraform init

      - name: Plan Terraform changes
        run: terraform plan -out=tfplan

      - name: Apply Terraform changes
        run: terraform apply --auto-approve

      - name: Clean up
        run: rm tfplan
```

#### 2. `Terraform Destroy` Workflow

This workflow is triggered manually to destroy the Terraform-managed resources:
- **Terraform Destroy**: Destroys the infrastructure created by Terraform.

```yaml
name: Terraform Destroy

on:
  workflow_dispatch:

jobs:
  destroy:
    runs-on: ubuntu-latest
    environment: aws
    env:
      AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
      AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
      AWS_DEFAULT_REGION: ${{ secrets.AWS_REGION }}

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Set up Terraform
        uses: hashicorp/setup-terraform@v2

      - name: Initialize Terraform
        run: terraform init

      - name: Destroy Terraform resources
        run: terraform destroy -auto-approve

      - name: Clean up
        run: rm -rf .terraform
```

## Configuration Variables

The configuration variables are defined in `variables.tf` (or `terraform.tfvars`):
- `aws_region`: AWS region to use (e.g., `"eu-west-1"`).
- `s3_bucket_name`: Name of the S3 bucket to be created.
- `ec2_instance_name`: Name for the EC2 instance.
- `instance_type`: Instance type for EC2 (e.g., `"t2.nano"`).
- `ami_id`: The Amazon Machine Image (AMI) ID for EC2.
- `global_tags`: Common tags to apply to all resources.

```hcl
aws_region      = "eu-west-1"
s3_bucket_name  = "my-s3-bucket-dd-mm-yyyy"
ec2_instance_name = "my-ec2-instance-dd-mm-yyyy"
instance_type   = "t2.nano"
ami_id          = "ami-07355fe79b493752d"
global_tags = {
  Environment = "Dev"
  Project     = "MyProject"
}
```

## Getting Started

### Step 1: Clone the repository
Clone the repository to your local machine:

```bash
git clone https://github.com/yourusername/aws-terraform-github-actions.git
cd aws-terraform-github-actions
```

### Step 2: Set up GitHub Secrets
Go to your GitHub repository's settings and add the following secrets:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION` (e.g., `eu-west-1`)

### Step 3: Trigger GitHub Actions Workflow
- Navigate to the "Actions" tab in your GitHub repository.
- Select the workflow (`Terraform Deploy` or `Terraform Destroy`).
- Trigger the workflow manually to deploy or destroy the resources.

## Conclusion

This repository provides a simple way to get started with managing AWS infrastructure using Terraform and GitHub Actions. It allows for easily deploying and destroying EC2 instances and S3 buckets with the help of automated workflows.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.