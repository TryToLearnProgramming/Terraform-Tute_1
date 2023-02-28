output "db_instance_id" {
  value = aws_db_instance.db_instance.id
}
output "db_instance_Name" {
  value = aws_db_instance.db_instance.name
}
output "db_instance_state" {
  value = aws_db_instance.db_instance.status
}
output "subnet_data" {
  value = data.aws_subnet_ids.available_db_subnet.ids
}
output "rds_address" {
  value = aws_db_instance.db_instance.address
}