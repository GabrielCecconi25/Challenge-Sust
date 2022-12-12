##Security-Group Instance##
resource "aws_security_group" "ec2_secgp" {
  name        = "Instance_security_group"
  description = "Security Group to instance"
  vpc_id      = aws_vpc.vpc1.id

  ingress {
    description = "ssh-vpn1"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["54.232.26.136/32"]
  }
  ingress {
    description = "ssh-vpn2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["186.192.143.189/32"]
  }
  ingress {
    description = "HTTPs"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
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

##Security-Group EKS##
resource "aws_security_group" "sg_eks" {
  name        = "Security_Group_eks"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc2.id

  ingress {
    description = "ssh-vpn1"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["54.232.26.136/32"]
  }
  ingress {
    description = "ssh-vpn2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["186.192.143.189/32"]
  }
  ingress {
    description = "HTTPs"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Security_Group_eks"
  }
}