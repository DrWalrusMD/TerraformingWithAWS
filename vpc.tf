resource "aws_vpc" "cisco-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "ciscovpc"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.cisco-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-west-1a"

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.cisco-vpc.id

  tags = {
    Name = "gateway"
  }
}

resource "aws_route_table" "public-table" {
  vpc_id = aws_vpc.cisco-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "public-table"
  }
}

resource "aws_route_table_association" "public-subnet-route" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-table.id
}
