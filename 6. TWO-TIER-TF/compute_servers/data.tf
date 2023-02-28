data "aws_vpc" "available" {
  filter {
    name   = "tag:Name"
    values = ["tcw_VPC"]
  }
}

data "aws_subnet_ids" "available_subnet" {
  vpc_id = data.aws_vpc.available.id
  filter {
    name = "tag:Name"
    values = ["Public*"]
  }
}
data "aws_security_group" "tcw_SG" {
  filter {
    name = "tag:Name"
    values = ["tcw_SG"]
  }
}
data "aws_ami" "amazon_linux_2" {
 most_recent = true
 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }
 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
 owners = ["amazon"]
}

data "template_file" "user_data" {
  template = file("./user-data.sh")
}