resource "azurerm_kubernetes_cluster" "shopflow" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group
  dns_prefix          = "shopflow"
  oidc_issuer_enabled       = true
  workload_identity_enabled = true
  
default_node_pool {
    name           = "system"
    node_count     = 1
    vm_size        = "Standard_B2s_v2"
    vnet_subnet_id = var.subnet_id
 }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    dns_service_ip = "10.2.0.10"
    service_cidr   = "10.2.0.0/24"
  }
}

resource "azurerm_role_assignment" "aks_acr" {
  principal_id                     = azurerm_kubernetes_cluster.shopflow.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = var.acr_id
  skip_service_principal_aad_check = true
}
