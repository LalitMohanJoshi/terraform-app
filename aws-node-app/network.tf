# define new vpc

resource "aws_vpc" "node-app-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "node-app-vpc"
  }
}

# define new subnet configuration

resource "aws_subnet" "node-app-subnet" {
  cidr_block        = cidrsubnet(aws_vpc.node-app-vpc.cidr_block, 3, 1)
  vpc_id            = aws_vpc.node-app-vpc.id
  availability_zone = var.aws_subnet_region
}


# define security groups configurations

resource "aws_security_group" "node-app-security-group" {
  name   = "node-app-sg"
  vpc_id = aws_vpc.node-app-vpc.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "ingress rule for node app 22 "
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "ingress rule for node app 80 "
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "egress rule for node app"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
}

# define internet gateway that route traffic from the internet to our VPC

resource "aws_internet_gateway" "node-app-gw" {
  vpc_id = aws_vpc.node-app-vpc.id
  tags = {
    Name = "node-app-gateway"
  }
}

# updating route tables

resource "aws_route_table" "node-app-rt" {
  vpc_id = aws_vpc.node-app-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.node-app-gw.id
  }

  tags = {
    Name = "node-app-route-table"
  }
}

resource "aws_route_table_association" "node-app-subnet-association" {
  subnet_id      = aws_subnet.node-app-subnet.id
  route_table_id = aws_route_table.node-app-rt.id
}
