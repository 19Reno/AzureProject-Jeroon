variable "resource_group" {
  default = "AzureProject"
}

variable "location" {
  default = "southafricanorth"
}

variable "acr_name" {
  default = "acrjeroon"
}

variable "aks_cluster_name" {
  default = "aks-shopflow"
}

variable "vnet_name" {
  default = "vnet-shopflow"
}

variable "kv_name" {
  default = "kv-shopflow-jeroon"
}

variable "db_name" {
  default = "psql-shopflow-jeroon"
}

variable "db_password" {
  sensitive = true
}
