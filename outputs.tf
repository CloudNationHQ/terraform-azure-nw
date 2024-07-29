output "watcher" {
  description = "contains all network watcher details"
  value       = azurerm_network_watcher.watcher
}

output "flowlog" {
  description = "contains all network watcher flow log details"
  value       = azurerm_network_watcher_flow_log.watcher_flowlog
}
