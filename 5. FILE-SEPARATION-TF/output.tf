output "ec2_arn" {
  value = aws_instance.ec2_1.arn
}
output "ec2_instance_state" {
  value = aws_instance.ec2_1.instance_state
}
output "ec2_public-dns" {
  value = aws_instance.ec2_1.public_dns
}
output "ec2_public_ip" {
  value = aws_instance.ec2_1.public_ip
}