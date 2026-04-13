output "db_host" {
  value = azurerm_postgresql_flexible_server.shopflow.fqdn
}

output "db_name" {
  value = azurerm_postgresql_flexible_server_database.shopflow.name
}
