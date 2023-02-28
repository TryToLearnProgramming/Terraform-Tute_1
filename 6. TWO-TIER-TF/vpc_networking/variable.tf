variable "vpc_name" {
  description = "Tag Name to be assigned with VPC"
  type        = string
  default     = "tcw_VPC"
}
variable "cidr" {
  description = "Enter the CIDR range required for VPC"
  type        = string
  default     = "192.172.0.0/16"
}
variable "enable_dns_hostnames" {
  description = "Enable DNS Hostname"
  type        = bool
  default     = null
}

variable "enable_dns_support" {
  description = "Enable DNS Support"
  type        = bool
  default     = null
}

variable "igw_tag" {
  description = "Name tag for Internet Gateway"
  type        = string
  default     = "tcw_igw"
}
variable "public_cidr_1" {
  description = "Public SubNet CIDR 1"
  type        = string
  default     = "192.172.1.0/24"
}
variable "public_cidr_2" {
  description = "Public SubNet CIDR 2"
  type        = string
  default     = "192.172.2.0/24"
}
variable "map_public_ip_on_launch" {
  description = "It will map the public ip while launching resources"
  type        = bool
  default     = null
}
variable "private_cidr_1" {
  description = "Private SubNet CIDR 1"
  type        = string
  default     = "192.172.5.0/24"
}
variable "private_cidr_2" {
  description = "Private SubNet CIDR 2"
  type        = string
  default     = "192.172.6.0/24"
}
variable "public_route_table_tag" {
  description = "Tag name for public route table"
  type        = string
  default     = "tcw_public_route_table"
}
variable "private_route_table_tag" {
  description = "Tag name for public route table"
  type        = string
  default     = "tcw_private_route_table_tag"
}