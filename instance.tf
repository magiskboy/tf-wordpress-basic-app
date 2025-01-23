resource "aws_instance" "wordpress_a" {
  ami           = "ami-0bd55ebedabddc3c0"
  instance_type = "t2.micro"
  associate_public_ip_address = false
  subnet_id = aws_subnet.private_subnet_a.id
  security_groups = [aws_security_group.private_sg.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_ssm_instance_profile.name
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras enable nginx1
              sudo yum install -y nginx
              echo "
              server {
                listen 80;

                location / {
                    default_type text/html;
                    return 200 \"
                        <!DOCTYPE html>
                        <html>
                        <head><title>Client IP</title></head>
                        <body>
                            <h1>Your IP is: $(hostname)</h1>
                        </body>
                        </html>\";
                }
              }
              " | sudo tee /etc/nginx/conf.d/default.conf
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = "wordpress_a"
  }
}

resource "aws_instance" "wordpress_b" {
  ami           = "ami-0bd55ebedabddc3c0"
  instance_type = "t2.micro"
  associate_public_ip_address = false
  subnet_id = aws_subnet.private_subnet_b.id
  security_groups = [aws_security_group.private_sg.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_ssm_instance_profile.name
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras enable nginx1
              sudo yum install -y nginx
              echo "
              server {
                listen 80;

                location / {
                    default_type text/html;
                    return 200 \"
                        <!DOCTYPE html>
                        <html>
                        <head><title>Client IP</title></head>
                        <body>
                            <h1>Your IP is: $(hostname)</h1>
                        </body>
                        </html>\";
                }
              }
              " | sudo tee /etc/nginx/conf.d/default.conf
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = "wordpress_b"
  }
}

