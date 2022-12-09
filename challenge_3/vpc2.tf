resource "aws_vpc" "vpc2" {
  cidr_block = "10.2.0.0/16"

  tags = {
    "Name" = "vpc-eks"
  }
}

##AZ:1a##
resource "aws_subnet" "sub2_01_pub" {
  vpc_id            = aws_vpc.vpc2.id
  cidr_block        = "10.2.1.0/24"
  availability_zone = var.az-1a

  tags = {
    "Name" = "Sub_Pub2_a"
  }
}


resource "aws_subnet" "sub2_01_priv" {
  vpc_id            = aws_vpc.vpc2.id
  cidr_block        = "10.2.11.0/24"
  availability_zone = var.az-1a

  tags = {
    "Name" = "Sub_Priv2_a"
  }
}

resource "aws_subnet" "sub2_01_db" {
  vpc_id            = aws_vpc.vpc2.id
  cidr_block        = "10.2.101.0/24"
  availability_zone = var.az-1a

  tags = {
    "Name" = "Sub_DB2_a"
  }
}

##AZ:1b##
resource "aws_subnet" "sub2_02_pub" {
  vpc_id            = aws_vpc.vpc2.id
  cidr_block        = "10.2.2.0/24"
  availability_zone = var.az-1b

  tags = {
    "Name" = "Sub_Pub2_b"
  }
}
resource "aws_subnet" "sub2_02_priv" {
  vpc_id            = aws_vpc.vpc2.id
  cidr_block        = "10.2.12.0/24"
  availability_zone = var.az-1b

  tags = {
    "Name" = "Sub_Priv2_b"
  }
}

resource "aws_subnet" "sub2_02_db" {
  vpc_id            = aws_vpc.vpc2.id
  cidr_block        = "10.2.102.0/24"
  availability_zone = var.az-1b

  tags = {
    "Name" = "Sub_DB2_b"
  }
}

#Internet_Gateway
resource "aws_internet_gateway" "igw2" {
  vpc_id = aws_vpc.vpc2.id

  tags = {
    "Name" = "igw2"
  }
}

#Nat_Gateway
resource "aws_eip" "nat_eip2" {
  vpc = true

  depends_on = [aws_internet_gateway.igw2]
  tags = {
    "Name" = "nat-eip2"
  }
}

resource "aws_nat_gateway" "nat2" {
  allocation_id = aws_eip.nat_eip2.id
  subnet_id     = aws_subnet.sub2_02_pub.id
}


##Routes-Table
resource "aws_route_table" "route_igw2" {
  vpc_id = aws_vpc.vpc2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw2.id
  }

  tags = {
    Name = "public_rt2"
  }
}

resource "aws_route_table_association" "rta2_public1" {
  subnet_id      = aws_subnet.sub2_01_pub.id
  route_table_id = aws_route_table.route_igw2.id
}

resource "aws_route_table_association" "rta2_public2" {
  subnet_id      = aws_subnet.sub2_02_pub.id
  route_table_id = aws_route_table.route_igw2.id
}



resource "aws_route_table" "route_nat2" {
  vpc_id = aws_vpc.vpc2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat2.id
  }

  tags = {
    Name = "private_rt2"
  }
}

resource "aws_route_table_association" "rta2_private1" {
  subnet_id      = aws_subnet.sub2_01_priv.id
  route_table_id = aws_route_table.route_nat2.id
}
resource "aws_route_table_association" "rta2_private2" {
  subnet_id      = aws_subnet.sub2_02_priv.id
  route_table_id = aws_route_table.route_nat2.id
}