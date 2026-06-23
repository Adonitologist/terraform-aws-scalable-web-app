terraform {
  backend "s3" {
    bucket  = "uan-terraform-state-web-app-2026-unique-123" # Must match exactly
    key     = "prod/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}