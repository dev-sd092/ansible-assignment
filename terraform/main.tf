provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "node_app_sg" {
  name        = "nodejs-app-sg"
  description = "Allow SSH and Node.js traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3007
    to_port     = 3007
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

resource "aws_instance" "node_app" {
  ami           = "ami-02d26659fd82cf299"  # change if needed
  instance_type = "t3.micro" # (free tier) change if needed
  key_name      = "EC2-sanket"  # change if needed
  vpc_security_group_ids = [aws_security_group.node_app_sg.id]

  tags = {
    Name = "nodejs-app-server"
  }
}

output "public_ip" {
  value = aws_instance.node_app.public_ip
}
