variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

output "lb_dns_name" {
  value = aws_lb.web_lb.dns_name
}