resource "azurerm_network_watcher" "watcher" {
  for_each = {
    for key, val in local.watchers :
    key => val if val.use_existing_watcher == false
  }

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group
  tags                = each.value.tags
}

data "azurerm_network_watcher" "existing_watcher" {
  for_each = {
    for key, val in local.watchers :
    key => val if val.use_existing_watcher == true
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group
}

resource "azurerm_network_watcher_flow_log" "watcher_flowlog" {
  for_each = {
    for fl in local.flowlogs : "${fl.watcher_key}.${fl.fl_key}" => fl
  }

  name                = each.value.flowlog_name
  location            = each.value.location
  resource_group_name = each.value.resource_group

  network_watcher_name = each.value.use_existing_watcher ? data.azurerm_network_watcher.existing_watcher[each.value.watcher_key].name : azurerm_network_watcher.watcher[each.value.watcher_key].name
  target_resource_id   = each.value.target_resource_id
  storage_account_id   = each.value.storage_account_id
  enabled              = each.value.enabled
  version              = each.value.version
  tags                 = each.value.tags

  retention_policy {
    enabled = each.value.retention_policy_enabled
    days    = each.value.retention_policy_days
  }

  dynamic "traffic_analytics" {
    for_each = each.value.traffic_analytics != null ? [each.value.traffic_analytics] : []

    content {
      enabled               = try(traffic_analytics.value.enabled, true)
      workspace_id          = traffic_analytics.value.workspace_id
      workspace_region      = traffic_analytics.value.workspace_region
      workspace_resource_id = traffic_analytics.value.workspace_resource_id
      interval_in_minutes   = try(traffic_analytics.value.interval_in_minutes, null)
    }
  }
}
