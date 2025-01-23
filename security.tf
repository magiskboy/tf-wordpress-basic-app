resource "aws_security_group" "public_sg" {
  name = "public_sg" 
  vpc_id = aws_vpc.aws_basic_app.id

  tags = {
    Name = "public_sg"
  }
}

resource "aws_security_group_rule" "public_sg_allow_http" {
  security_group_id = aws_security_group.public_sg.id
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "public_sg_allow_all_outcomming" {
  security_group_id = aws_security_group.public_sg.id
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group" "private_sg" {
  name = "private_sg" 
  vpc_id = aws_vpc.aws_basic_app.id

  tags = {
    Name = "private_sg"
  }
}

resource "aws_security_group_rule" "private_sg_allow_ssh" {
  security_group_id = aws_security_group.private_sg.id
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "private_sg_allow_http" {
  security_group_id = aws_security_group.private_sg.id
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "private_sg_allow_all_outcomming" {
  security_group_id = aws_security_group.private_sg.id
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
