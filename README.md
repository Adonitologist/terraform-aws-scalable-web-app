# AWS Scalable Web App Architecture

![Terraform CI](https://github.com/Adonitologist/terraform-aws-scalable-web-app/actions/workflows/ci.yml/badge.svg)
![Terraform](https://img.shields.io/badge/IaC-Terraform_v1.5+-844FBA?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-VPC_%7C_ALB_%7C_ASG-232F3E?logo=amazon-aws)
![Security](https://img.shields.io/badge/Security-Private_Subnets_%26_NAT-success)

Production-ready scalable web application hosted on AWS. Built using modular Infrastructure as Code (IaC) via Terraform, enforcing strict network isolation by placing compute instances in private subnets behind an Application Load Balancer and a NAT Gateway.

## System Architecture

mermaid
flowchart TD
Client([User Browser]) -->|HTTP / Port 80| ALB[Application Load Balancer\nPublic Subnets]
ALB -->|Forward Traffic| ASG[Auto Scaling Group\nPrivate Subnets]
subgraph VPC [AWS Virtual Private Cloud 10.0.0.0/16]
subgraph Public Tier
ALB
IGW[Internet Gateway]
NAT[NAT Gateway]
end
subgraph Private Tier
ASG
end
end
ASG -->|Outbound Updates via NAT| NAT
NAT -->|Route to Internet| IGW


## Core Technical Highlights

* **Strict Network Isolation:** Compute workloads (EC2 instances managed by an Auto Scaling Group) reside entirely in private subnets without public IPs.
* **High Availability & Load Balancing:** Traffic enters via an Application Load Balancer deployed across multi-AZ public subnets, distributing requests securely to private instances.
* **Outbound NAT Routing:** Private instances leverage a NAT Gateway attached to an Elastic IP in the public tier to safely download packages and updates.
* **Automated Quality Gates:** Integrated GitHub Actions workflow running `terraform fmt`, `tflint` static analysis, and `tfsec` security scans on every push.

## Repository Structure

text
.
├── .github/workflows/
│   └── ci.yml                # Terraform Validation & Security Pipeline
├── modules/
│   ├── compute/              # EC2, Auto Scaling Group, ALB, User Data HTML
│   └── vpc/                  # VPC, Public/Private Subnets, NAT Gateway, SGs
├── main.tf                   # Root Module Orchestration
├── variables.tf              # Global Variables Definition
├── outputs.tf                # Infrastructure Outputs (ALB DNS)
└── backend.tf                # S3 Remote State Backend Configuration


## Execution Commands

1. Initialize remote S3 backend:

bash
terraform init

2. Validate infrastructure syntax:

bash
terraform validate

3. Deploy infrastructure:

bash
terraform apply

4. Destroy infrastructure (Zero-Cost Baseline):

bash
terraform destroy

