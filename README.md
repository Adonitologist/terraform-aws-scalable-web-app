# AWS Scalable Web Application (Terraform)

## Project Overview
This project provisions a highly available, scalable infrastructure on AWS using Terraform. 
It demonstrates the use of industry-standard patterns including:
- **Networking:** Custom VPC with public and private subnets.
- **High Availability:** Application Load Balancer (ALB) distributing traffic across multiple instances.
- **Scalability:** Auto Scaling Group (ASG) for dynamic resource management.
- **Security:** Security Groups enforcing least-privilege access.

## Architecture
[Insert a link to a diagram here, or a simple text-based diagram like this]
Internet -> ALB -> Public Subnet -> Auto Scaling Group (Private Subnet)

## Prerequisites
- AWS Account
- Terraform installed
- GitHub Secrets configured (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`)

## Deployment
This project is fully automated via **GitHub Actions**. 
- Push to `main` triggers a `terraform apply` deployment.
- Manual destruction can be triggered via the "Destroy Infrastructure" workflow.

## Cleanup
To tear down the infrastructure, run the "Destroy Infrastructure" workflow from the GitHub Actions tab.
