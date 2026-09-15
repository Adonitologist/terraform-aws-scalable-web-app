output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [aws_subnet.public_1.id, aws_subnet.public_2.id]
}

output "private_subnet_ids" {
  value = [aws_subnet.private_1.id, aws_subnet.private_2.id]
}

output "lb_sg_id" {
  value = aws_security_group.lb_sg.id
}

output "instance_sg_id" {
  value = aws_security_group.instance_sg.id
}