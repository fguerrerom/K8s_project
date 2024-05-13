terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.49.0"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region_blockstellart
}
# Crear un grupo de seguridad para SSH y HTTP
resource "aws_security_group" "web" {
  name        = "blockstellart_sg"
  description = "Security group para permitir SSH y HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#Crear una instancia EC2
resource "aws_instance" "blockstellart" {
  ami           = var.ami_id
  instance_type = var.instance_type
  #key_name = var.key_name
  security_groups = [aws_security_group.web.name]
  tags = {
    Name = "BlockStellartInstance"
  }

  user_data = <<EOF
                #!/bin/bash
                # Utiliza esto para tus datos de usuario
                yum update -y
                yum install -y httpd
                systemctl start httpd
                systemctl enable httpd
                echo "<h1> Hola Mundo desde $(hostname -f)</h1>" > /var/www/html/index.html
                EOF
}
