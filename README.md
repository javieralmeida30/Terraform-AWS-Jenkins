# Terraform Jenkins AWS

This repository provides Terraform code to automate the deployment of a Jenkins environment on Amazon Web Services (AWS). It provisions an EC2 instance, an RDS MySQL database, and an S3 bucket, and installs and configures Jenkins within the EC2 instance. The infrastructure can be easily created, modified, and destroyed using Terraform.

## Prerequisites

Before you begin, ensure you have the following:

- An AWS account with appropriate permissions to create EC2 instances, RDS instances, and S3 buckets.
- Terraform installed on your local machine.

## Usage

Clone this repository to your local machine.

git clone https://github.com/your-username/terraform-jenkins-aws.git

Navigate to the terraform directory.
cd terraform

Open variables.tf and modify the variables as per your requirements.

Initialize Terraform.
terraform init

Review the execution plan.
terraform plan

Apply the Terraform configuration to create the infrastructure.
terraform apply

Once the deployment is complete, you can access Jenkins by using the public IP address of the EC2 instance through HTTP on port 8080.

Clean Up
To tear down the infrastructure and destroy all resources created by Terraform, run:
terraform destroy

Make sure to review the execution plan before proceeding.
