# This outputs the DNS name of the Load Balancer so you can access your app
output "lb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = aws_lb.web_lb.dns_name
}

# It is good practice to also output the ASG name if you need to manage it later
output "autoscaling_group_name" {
  description = "The name of the Auto Scaling Group."
  value       = aws_autoscaling_group.web_asg.name
}