resource "aws_vpc" "vpc1" {
  cidr_block = "10.1.0.0/16"

  tags = {
    "Name" = "vpc-net1"
  }
}

##AZ:1a##
resource "aws_subnet" "sub1_01_pub" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = var.az-1a

  tags = {
    "Name" = "Sub_Pub1_a"
  }
}


resource "aws_subnet" "sub1_01_priv" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.1.11.0/24"
  availability_zone = var.az-1a

  tags = {
    "Name" = "Sub_Priv1_a"
  }
}

resource "aws_subnet" "sub1_01_db" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.1.101.0/24"
  availability_zone = var.az-1a

  tags = {
    "Name" = "Sub_DB1_a"
  }
}

##AZ:1b##
resource "aws_subnet" "sub1_02_pub" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.1.2.0/24"
  availability_zone = var.az-1b

  tags = {
    "Name" = "Sub_Pub1_b"
  }
}
resource "aws_subnet" "sub1_02_priv" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.1.12.0/24"
  availability_zone = var.az-1b

  tags = {
    "Name" = "Sub_Priv1_b"
  }
}

resource "aws_subnet" "sub1_02_db" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.1.102.0/24"
  availability_zone = var.az-1b

  tags = {
    "Name" = "Sub_DB1_b"
  }
}

#Internet_Gateway
resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    "Name" = "igw"
  }
}

#Nat_Gateway
resource "aws_eip" "nat_eip1" {
  vpc = true

  depends_on = [aws_internet_gateway.igw1]
  tags = {
    "Name" = "nat-eip"
  }
}

resource "aws_nat_gateway" "nat1" {
  allocation_id = aws_eip.nat_eip1.id
  subnet_id     = aws_subnet.sub1_02_pub.id
}

##Routes-Table##
resource "aws_route_table" "route_igw1" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
  }

  tags = {
    Name = "public_rt1"
  }
}

resource "aws_route_table_association" "rta1_public1" {
  subnet_id      = aws_subnet.sub1_01_pub.id
  route_table_id = aws_route_table.route_igw1.id
}

resource "aws_route_table_association" "rta1_public2" {
  subnet_id      = aws_subnet.sub1_02_pub.id
  route_table_id = aws_route_table.route_igw1.id
}



resource "aws_route_table" "route_nat1" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat1.id
  }

  tags = {
    Name = "private_rt1"
  }
}

resource "aws_route_table_association" "rta1_private1" {
  subnet_id      = aws_subnet.sub1_01_priv.id
  route_table_id = aws_route_table.route_nat1.id
}
resource "aws_route_table_association" "rta1_private2" {
  subnet_id      = aws_subnet.sub1_02_priv.id
  route_table_id = aws_route_table.route_nat1.id
}