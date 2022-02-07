#-------------------------------------------------------------------------------
# My Terraform
#
# Build WebServer during bootstrap
#
#-------------------------------------------------------------------------------

provider "aws" {
  region = "eu-west-1"

}

resource "aws_instance" "WebServer" {
  count                  = 1                       # count of created instances
  ami                    = "ami-00ae935ce6c2aa534" # ID of AWS AMI
  instance_type          = "t2.micro"              # type of instance
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data              = <<EOF
#!bin/bash
yum -y update
yum -y install httpd
echo "<h2>WebServer with ip: $(hostname -f)</h2><br>Built with Terraform!" > var/www/html/index.html
sudo service httpd start
chkconfig httpd on
EOF
  tags = {
    Name    = "Web Server"
    Owner   = "Alexandr Butylin"
    Project = "WebServer"
  }
}

resource "aws_security_group" "my_webserver" {
  name        = "WebServer"
  description = "Open 80th port"

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # Any protocol
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
