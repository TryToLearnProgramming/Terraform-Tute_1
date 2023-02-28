resource "aws_instance" "ec2_1" {
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.selected.id
  key_name = var.my_key
  tags = {
    Name = "EC2-HelloAWs"
  }
}
