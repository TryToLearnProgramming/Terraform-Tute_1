resource "aws_lb_listener" "tcw_alb_listeners"{
  load_balancer_arn = aws_lb.tcw_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tcw_tg.arn
  }
}