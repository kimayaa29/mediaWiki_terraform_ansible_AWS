resource "aws_vpc" "mw_vpc" {
  cidr_block = var.vpc-cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    "Name" = "mediawiki"
  }
}

resource "aws_internet_gateway" "mw_igw" {
  vpc_id = aws_vpc.mw_vpc.id
  tags = {
    "Name" = "mediawiki"
  }
}

resource "aws_subnet" "mw_subnet" {
  cidr_block = var.subnet-cidr
  vpc_id = aws_vpc.mw_vpc.id
  map_public_ip_on_launch = true
  availability_zone = var.availability_zone
  tags = {
    "Name" = "mediawiki"
  }
}

resource "aws_route_table" "mw_rt" {
  vpc_id = aws_vpc.mw_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mw_igw.id
  }
  tags = {
    "Name" = "mediawiki"
  }
}

resource "aws_route_table_association" "mw_rt_assoc" {
  route_table_id = aws_route_table.mw_rt.id
  subnet_id = aws_subnet.mw_subnet.id
}

resource "aws_security_group" "mw_sg" {
  name = "mw_sg"
  vpc_id = aws_vpc.mw_vpc.id
  ingress {
    from_port = 22
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    to_port = 22
  }
  ingress {
    from_port = 80
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    to_port = 80
  }
  egress {
    from_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    to_port = 0
  }
  tags = {
    "Name" = "mediawiki"
  }
}

