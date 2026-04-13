resource "azurerm_private_dns_zone" "postgres" {
  name                = "shopflow.postgres.database.azure.com"
  resource_group_name = var.resource_group
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgres" {
  name                  = "shopflow-postgres-link"
  resource_group_name   = var.resource_group
  private_dns_zone_name = azurerm_private_dns_zone.postgres.name
  virtual_network_id    = var.vnet_id
}

resource "azurerm_postgresql_flexible_server" "shopflow" {
  name                          = var.db_name
  resource_group_name           = var.resource_group
  location                      = var.location
  version                       = "15"
  delegated_subnet_id           = var.subnet_id
  private_dns_zone_id           = azurerm_private_dns_zone.postgres.id
  administrator_login           = "shopflowadmin"
  administrator_password        = var.db_password
  zone                          = "1"
  storage_mb                    = 32768
  sku_name                      = "B_Standard_B1ms"
  public_network_access_enabled = false
  depends_on = [azurerm_private_dns_zone_virtual_network_link.postgres]
}

resource "azurerm_postgresql_flexible_server_database" "shopflow" {
  name      = "shopflowdb"
  server_id = azurerm_postgresql_flexible_server.shopflow.id
}
