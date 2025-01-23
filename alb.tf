resource "aws_lb" "public_alb" {
  name = "publicalb"
  load_balancer_type = "application"

  subnet_mapping {
    subnet_id = aws_subnet.public_subnet_a.id
  }

  subnet_mapping {
    subnet_id = aws_subnet.public_subnet_b.id
  }

  security_groups = [aws_security_group.public_sg.id]

  tags = {
    Name = "public_alb"
  }
}

resource "aws_lb_target_group" "public_alb_target_group" {
  name = "public-alb-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.aws_basic_app.id

  tags = {
    Name = "public_alb_target_group"
  }
}

resource "aws_lb_target_group_attachment" "public_alb_target_group_attachment_a" {
  target_group_arn = aws_lb_target_group.public_alb_target_group.arn
  target_id = aws_instance.wordpress_a.id
  port = 80
}

resource "aws_lb_target_group_attachment" "public_alb_target_group_attachment_b" {
  target_group_arn = aws_lb_target_group.public_alb_target_group.arn
  target_id = aws_instance.wordpress_b.id
  port = 80
}

resource "aws_lb_listener" "public_alb_listener" {
  load_balancer_arn = aws_lb.public_alb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.public_alb_target_group.arn
  }
}

output "alb_dns_name" {
  value = aws_lb.public_alb.dns_name
}
