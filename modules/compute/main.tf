data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_lb" "web_lb" {
  name               = "web-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids
  security_groups    = [var.lb_sg_id]
}

resource "aws_lb_target_group" "web_tg" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

resource "aws_launch_template" "app_template" {
  name_prefix            = "app-server-"
  image_id               = data.aws_ami.amazon_linux_2023.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [var.instance_sg_id]
  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y nginx
    systemctl start nginx
    systemctl enable nginx
    cat << 'HTML' > /usr/share/nginx/html/index.html
    ${file("${path.module}/index.html")}
    HTML
  EOF
  )
}

resource "aws_autoscaling_group" "web_asg" {
  vpc_zone_identifier = var.private_subnet_ids
  min_size            = 1
  max_size            = 3
  desired_capacity    = 2
  launch_template {
    id      = aws_launch_template.app_template.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.web_asg.id
  lb_target_group_arn    = aws_lb_target_group.web_tg.arn
}
