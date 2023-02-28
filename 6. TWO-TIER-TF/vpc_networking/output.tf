output "vpc" {
    value = aws_vpc.test_VPC1.id
}
output "vpc_name" {
    value = aws_vpc.test_VPC1.tags.Name
}
output "subnets_name" {
    value = [aws_subnet.pr_subnet1.id, aws_subnet.pr_subnet2.id]
}