resource "azurerm_network_watcher" "nwatcher" {
  name                = var.nwatcher.name
  location            = coalesce(lookup(var.nwatcher, "location", null), var.location)
  resource_group_name = coalesce(lookup(var.nwatcher, "resource_group", null), var.resourcegroup)
  tags                = try(var.nwatcher.tags, var.tags, null)
}

resource "azurerm_network_watcher_flow_log" "nwatcher_flowlog" {
  for_each = try(
    { for flowlog in local.flowlogs : flowlog.nwfl_key => flowlog }, {}
  )

  name                = each.value.flowlog_name
  location            = coalesce(lookup(var.nwatcher, "location", null), var.location)
  resource_group_name = coalesce(lookup(var.nwatcher, "resource_group", null), var.resourcegroup)

  network_watcher_name      = each.value.network_watcher_name
  network_security_group_id = each.value.network_security_group_id
  storage_account_id        = each.value.storage_account_id
  enabled                   = each.value.enabled
  version                   = each.value.version
  tags                      = each.value.tags

  retention_policy {
    enabled = each.value.retention_policy.enabled
    days    = each.value.retention_policy.days
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
