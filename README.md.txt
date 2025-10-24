# Terraform Flask + Express Deployment (AWS)

This project contains three parts:

- Part 1 — Deploy Flask + Express on a single EC2 instance.
- Part 2 — Deploy Flask and Express on separate EC2 instances.
- Part 3 — Deploy Flask and Express as Docker containers using ECR, ECS (Fargate) and an ALB.

## Prerequisites

- Terraform >= 1.0
- AWS CLI configured with credentials
- Docker (for Part 3)
- An S3 bucket for tfstate (create manually or modify backend)
- A key pair in your AWS region (for EC2 parts)
- Fill in placeholders in variables or pass them via `-var` flags.

## Basic usage (example)

### Part 1 (single EC2)

```bash
cd part1_single_ec2
terraform init
terraform plan -var="ami=<AMI_ID>" -var="key_name=<KEY_NAME>" -var="tfstate_bucket=<YOUR_BUCKET>"
terraform apply -var="ami=<AMI_ID>" -var="key_name=<KEY_NAME>" -var="tfstate_bucket=<YOUR_BUCKET>" -auto-approve
# After apply, see outputs for public IP
