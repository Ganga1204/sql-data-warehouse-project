provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example_instance" {
  ami                    = "ami-0a0ebee827a585d06"
  instance_type          = "t2.micro"
  key_name               = "gkey"
  vpc_security_group_ids = [aws_security_group.example_sg.id]
  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }
  tags = {
    Name = "WindowsInstance"
  }
}

resource "aws_security_group" "example_sg" {
  name        = "example_security_group"
  description = "Allow SSH and HTTP access"

  ingress {
    from_port   = 3389
    to_port     = 3389
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

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.example_instance.public_ip
}

output "instance_private_ip" {
  description = "The private IP address of the EC2 instance"
  value       = aws_instance.example_instance.private_ip
}