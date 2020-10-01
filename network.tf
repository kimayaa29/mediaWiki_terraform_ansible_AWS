resource "aws_vpc" "mw_vpc" {
  cidr_block = var.vpc-cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    "Name" = "mediawiki-vpc"
  }
}

resource "aws_internet_gateway" "mw_igw" {
  vpc_id = aws_vpc.mw_vpc.id
  tags = {
    "Name" = "mediawiki-igw"
  }
}

resource "aws_subnet" "mw_subnet_public_1" {
  cidr_block = var.subnet-cidr-public-1
  vpc_id = aws_vpc.mw_vpc.id
  map_public_ip_on_launch = true
  availability_zone = var.availability_zone_1a
  tags = {
    "Name" = "mediawiki-subnet-1"
  }
}

resource "aws_subnet" "mw_subnet_public_2" {
  cidr_block = var.subnet-cidr-public-2
  vpc_id = aws_vpc.mw_vpc.id
  map_public_ip_on_launch = true
  availability_zone = var.availability_zone_1b
}

resource "aws_route_table" "mw_rt" {
  vpc_id = aws_vpc.mw_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mw_igw.id
  }
  tags = {
    "Name" = "mediawiki-rt"
  }
}

resource "aws_route_table_association" "mw_rt_association_1" {
  route_table_id = aws_route_table.mw_rt.id
  subnet_id = aws_subnet.mw_subnet_public_1.id
}

resource "aws_route_table_association" "mw_rt_association_2" {
  route_table_id = aws_route_table.mw_rt.id
  subnet_id = aws_subnet.mw_subnet_public_2.id
}

resource "aws_security_group" "mw_sg" {
  name = "mw_sg"
  vpc_id = aws_vpc.mw_vpc.id
  description = "to allow http traffic and ssh connections"

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

resource "aws_security_group" "mw_elb_sg" {
  vpc_id = aws_vpc.mw_vpc.id
  name = "mediawiki-elb-sg"
  description = "allow http to instances through ELB"

  ingress {
    from_port = 80
    protocol = "TCP"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "mediawiki-elb-security group"
  }
}
