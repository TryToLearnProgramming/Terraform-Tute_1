resource "aws_lb" "tcw_alb" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.tcw_SG.id]
  subnets            = data.aws_subnet_ids.available_subnet.ids

  enable_deletion_protection = false
  tags = {
    Environment = "dev"
  }
}