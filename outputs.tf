output "watcher" {
  description = "contains network watcher details"
  value = {
    for key, val in var.watchers : key => val.use_existing_watcher ? data.azurerm_network_watcher.this[key] : azurerm_network_watcher.this[key]
  }
}

output "flowlog" {
  description = "contains all network watcher flow log details"
  value       = azurerm_network_watcher_flow_log.this
}
