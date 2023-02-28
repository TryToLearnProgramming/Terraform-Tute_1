# Single tire Architecture
provider "aws" {
  region = "us-east-1"
}

######### VPC_BLOCK ########

resource "aws_vpc" "TF_VPC" {
  cidr_block = "192.172.0.0/16"

  tags = {
    Name = "TF_VPC"
  }
}

######### Internet_Gateway ##########

resource "aws_internet_gateway" "TF_igw" {
  vpc_id = aws_vpc.TF_VPC.id

  tags = {
    Name = "TF_igw"
  }
}

########### SubNet #############

resource "aws_subnet" "TF_subnet" {
  vpc_id     = aws_vpc.TF_VPC.id
  cidr_block = "192.172.0.0/20"

  tags = {
    Name = "TF_subnet1"
  }
}

############ Rout_Table #############

resource "aws_route_table" "TF_RT" {
  vpc_id = aws_vpc.TF_VPC.id

  route = []
  tags = {
    Name = "TF_RT"
  }
}

############ Rout ################

resource "aws_route" "rout" {
  route_table_id         = aws_route_table.TF_RT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.TF_igw.id
  depends_on             = [aws_route_table.TF_RT]
}

########### Security_Group ##############

resource "aws_security_group" "TF_SG" {
  name        = "all_Trafic"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.TF_VPC.id

  ingress { #InBound Rule
    description      = "all trafic"
    from_port        = 0    #all ports
    to_port          = 0    #all ports
    protocol         = "-1" #all trafic
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = null
    prefix_list_ids  = null
    security_groups  = null
    self             = null
  }

  egress { #OutBound Rule
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description      = "Outbound ruls"
    prefix_list_ids  = null
    security_groups  = null
    self             = null
  }

  tags = {
    Name = "TF_SG_all_trafic"
  }
}

############# Rout_Table_Association ############

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.TF_subnet.id
  route_table_id = aws_route_table.TF_RT.id
}

############# EC2_Instance #################

resource "aws_instance" "tfi" {
  ami           = "ami-04505e74c0741db8d" # prefrable AMI
  instance_type = "t2.micro"
  key_name      = "tcw" # created key pair
  subnet_id     = aws_subnet.TF_subnet.id
  vpc_security_group_ids = [aws_security_group.TF_SG.id]
  tags = {
    Name = "TF-EC2"
  }
}