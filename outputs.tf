output "watcher" {
  description = "contains network watcher details"
  value = {
    for key, val in local.watchers : key => val.use_existing_watcher == true ? try(data.azurerm_network_watcher.existing_watcher[key], null) : try(azurerm_network_watcher.watcher[key], null)
  }
}

output "flowlog" {
  description = "contains all network watcher flow log details"
  value       = azurerm_network_watcher_flow_log.watcher_flowlog
}
