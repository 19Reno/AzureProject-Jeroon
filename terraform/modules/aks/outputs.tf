output "cluster_name" {
  value = azurerm_kubernetes_cluster.shopflow.name
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.shopflow.kube_config_raw
  sensitive = true
}

output "cluster_id" {
  value = azurerm_kubernetes_cluster.shopflow.id
}
