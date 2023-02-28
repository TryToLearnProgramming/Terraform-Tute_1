variable "engine_name" {
  type    = string
  default = "mysql"
}
variable "db_name" {
  type    = string
  default = "tcw"
}
variable "user_name" {
  type    = string
  default = "terraform"
}
variable "pass" {
  type    = string
  default = "tcw#db#123"
}
variable "skip_finalSnapshot" {
  type    = string
  default = true
}
variable "delete_automated_backup" {
  type    = string
  default = true
}
variable "multi_az_deployment" {
  type    = string
  default = false
}
variable "public_access" {
  type    = string
  default = false
}
variable "instance_class" {
  type    = string
  default = "db.t2.micro"
}
