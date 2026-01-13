output "watcher" {
  description = "contains network watcher details"
  value = {
    for key, val in var.watchers : key => val.use_existing_watcher ? data.azurerm_network_watcher.existing_watcher[key] : azurerm_network_watcher.watcher[key]
  }
}

output "flowlog" {
  description = "contains all network watcher flow log details"
  value       = azurerm_network_watcher_flow_log.watcher_flowlog
}
