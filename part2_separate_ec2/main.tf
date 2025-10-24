data "aws_vpc" "default" {
  default = true
}

# Security group for Flask instance -- allow 5000 from anywhere or specific
resource "aws_security_group" "flask_sg" {
  name        = "flask-sg"
  description = "Allow flask port and ssh"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Flask public access (adjust as needed)"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security group for Express instance -- allow 3000 public, allow flask instance to talk to it if needed
resource "aws_security_group" "express_sg" {
  name        = "express-sg"
  description = "Allow express port and ssh"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Express public access"
  }

  # allow express to receive from flask (optional) - using SG reference
  ingress {
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.flask_sg.id]
    description     = "Allow flask SG"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "flask_instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.flask_sg.id]

  user_data = file("${path.module}/flask_user_data.sh")

  tags = {
    Name = "flask-instance"
  }
}

resource "aws_instance" "express_instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.express_sg.id]

  user_data = file("${path.module}/express_user_data.sh")

  tags = {
    Name = "express-instance"
  }
}
