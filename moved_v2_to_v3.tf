moved {
  from = azurerm_network_watcher.watcher
  to   = azurerm_network_watcher.this
}

moved {
  from = data.azurerm_network_watcher.existing_watcher
  to   = data.azurerm_network_watcher.this
}

moved {
  from = azurerm_network_watcher_flow_log.watcher_flowlog
  to   = azurerm_network_watcher_flow_log.this
}
