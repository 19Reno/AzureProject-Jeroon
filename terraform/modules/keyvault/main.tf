data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "shopflow" {
  name                = var.kv_name
  resource_group_name = var.resource_group
  location            = var.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = ["Get", "Set", "List", "Delete", "Purge"]
  }
}

resource "azurerm_key_vault_secret" "db_password" {
  name         = "db-password"
  value        = var.db_password
  key_vault_id = azurerm_key_vault.shopflow.id
}
