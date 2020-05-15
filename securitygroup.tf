resource "aws_security_group" "sgroup-allow-ssh-http" {
  vpc_id      = aws_vpc.cisco-vpc.id
  name        = "sgroup-allow-ssh-http"
  description = "Security group for EC2 instance, allows HTTP/SSH"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.sgroup-elb.id]
  }

  tags = {
    Name = "sgroup-allow-http/ssh"
  }
}

resource "aws_security_group" "sgroup-elb" {
  vpc_id      = aws_vpc.cisco-vpc.id
  name        = "sgroup-elb"
  description = "security group for ELB,allows HTTP"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sgroup-elb"
  }
}
