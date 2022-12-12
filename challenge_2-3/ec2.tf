resource "aws_instance" "web" {
  key_name      = "ec2_key"
  ami           = "ami-08c40ec9ead489470"
  instance_type = "t3.micro"

  network_interface {
    network_interface_id = aws_network_interface.web.id
    device_index         = 0
  }

  tags = {
    Name = "Srv-Web"
  }
}

resource "aws_eip" "eip" {
  instance = aws_instance.web.id


  tags = {
    "Name" = "nat-eip"
  }
}

resource "aws_network_interface" "web" {
  subnet_id       = aws_subnet.sub1_01_pub.id
  private_ips     = ["10.1.1.100"]
  security_groups = [aws_security_group.ec2_secgp.id]

  tags = {
    Name = "network_interface"
  }
}