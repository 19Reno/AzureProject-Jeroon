terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

module "network" {
  source         = "./modules/network"
  resource_group = var.resource_group
  location       = var.location
  vnet_name      = var.vnet_name
}

module "aks" {
  source         = "./modules/aks"
  resource_group = var.resource_group
  location       = var.location
  cluster_name   = var.aks_cluster_name
  subnet_id      = module.network.aks_subnet_id
  acr_id         = data.azurerm_container_registry.existing.id
}

module "keyvault" {
  source         = "./modules/keyvault"
  resource_group = var.resource_group
  location       = var.location
  kv_name        = var.kv_name
  db_password    = var.db_password
}

module "database" {
  source         = "./modules/database"
  resource_group = var.resource_group
  location       = var.location
  db_name        = var.db_name
  db_password    = var.db_password
  subnet_id      = module.network.db_subnet_id
  vnet_id        = module.network.vnet_id
}

data "azurerm_container_registry" "existing" {
  name                = var.acr_name
  resource_group_name = var.resource_group
}
