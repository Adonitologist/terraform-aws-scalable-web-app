variable "vpc_id" { type = string }
variable "public_subnet_ids" { type = list(string) }
variable "private_subnet_ids" { type = list(string) }
variable "lb_sg_id" { type = string }
variable "instance_sg_id" { type = string }
