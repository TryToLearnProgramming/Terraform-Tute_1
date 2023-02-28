################## vpc ######################
resource "aws_vpc" "test_VPC1" {
  cidr_block           = var.cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = {
    Name = var.vpc_name
  }
}

################### IGW ######################
resource "aws_internet_gateway" "myIGW" {
  vpc_id = aws_vpc.test_VPC1.id
  tags = {
    Name = var.igw_tag
  }
}

################### Public Subnet ########################
resource "aws_subnet" "p_subnet1" {
  vpc_id                  = aws_vpc.test_VPC1.id
  cidr_block              = var.public_cidr_1
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = "Public-SN1"
  }
}

resource "aws_subnet" "p_subnet2" {
  vpc_id                  = aws_vpc.test_VPC1.id
  cidr_block              = var.public_cidr_2
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = "Public-SN2"
  }
}

################### Private Subnet ########################
resource "aws_subnet" "pr_subnet1" {
  vpc_id                  = aws_vpc.test_VPC1.id
  cidr_block              = var.private_cidr_1
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "Private-SN1"
  }
}

resource "aws_subnet" "pr_subnet2" {
  vpc_id                  = aws_vpc.test_VPC1.id
  cidr_block              = var.private_cidr_2
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "Private-SN2"
  }
}

################### Public Routes ####################
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.test_VPC1.id
  tags = {
    Name = var.public_route_table_tag
  }
}
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.myIGW.id
}

################## Private Route Table ################
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.test_VPC1.id
  tags = {
    Name = var.private_route_table_tag
  }
}

############## Route Table Association ################
resource "aws_route_table_association" "public_rt_association_1" {
  subnet_id      = aws_subnet.p_subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "public_rt_association_2" {
  subnet_id      = aws_subnet.p_subnet2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_rt_association_1" {
  subnet_id      = aws_subnet.pr_subnet1.id
  route_table_id = aws_route_table.private_route_table.id
}
resource "aws_route_table_association" "private_rt_association_2" {
  subnet_id      = aws_subnet.pr_subnet2.id
  route_table_id = aws_route_table.private_route_table.id
}

############### Security Groups ##################
resource "aws_security_group" "test_Sg" {
  name        = "tcw_SG"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.test_VPC1.id

  ingress {
    description      = "All from VPC"
    from_port        = 0  # All ports
    to_port          = 0  # All ports
    protocol         = "-1" # All traffic
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = null
    prefix_list_ids  = null
    security_groups  = null
    self             = null
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description      = "Outbound rule"
    prefix_list_ids  = null
    security_groups  = null
    self             = null
  }

  tags = {
    Name = "tcw_SG"
  }
}