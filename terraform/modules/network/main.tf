resource "azurerm_virtual_network" "shopflow" {
  name                = var.vnet_name
  resource_group_name = var.resource_group
  location            = var.location
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "aks" {
  name                 = "snet-aks"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.shopflow.name
  address_prefixes     = ["10.1.1.0/24"]
}

resource "azurerm_subnet" "db" {
  name                 = "snet-db"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.shopflow.name
  address_prefixes     = ["10.1.2.0/24"]

  delegation {
    name = "db-delegation"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action"
      ]
    }
  }
}

resource "azurerm_network_security_group" "shopflow" {
  name                = "nsg-shopflow"
  resource_group_name = var.resource_group
  location            = var.location

  security_rule {
    name                       = "allow-http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-https"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
