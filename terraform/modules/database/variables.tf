variable "resource_group" {}
variable "location" {}
variable "db_name" {}
variable "db_password" {
  sensitive = true
}
variable "subnet_id" {}
variable "vnet_id" {}
