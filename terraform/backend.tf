terraform {
  backend "azurerm" {
    resource_group_name  = "AzureProject"
    storage_account_name = "stshopflowjeroon"
    container_name       = "tfstate"
    key                  = "shopflow.tfstate"
  }
}
