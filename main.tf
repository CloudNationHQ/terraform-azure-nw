resource "azurerm_network_watcher" "watcher" {
  for_each = {
    for watcher_key, watcher in var.watchers : watcher_key => watcher
    if watcher.use_existing_watcher == false
  }

  name = each.value.name

  resource_group_name = coalesce(
    each.value.resource_group_name,
    var.resource_group_name
  )

  location = coalesce(
    each.value.location,
    var.location
  )

  tags = coalesce(
    each.value.tags,
    var.tags
  )
}

data "azurerm_network_watcher" "existing_watcher" {
  for_each = {
    for watcher_key, watcher in var.watchers : watcher_key => watcher
    if watcher.use_existing_watcher == true
  }

  name = each.value.name

  resource_group_name = coalesce(
    each.value.resource_group_name,
    var.resource_group_name
  )
}

resource "azurerm_network_watcher_flow_log" "watcher_flowlog" {
  for_each = {
    for fl in flatten([
      for watcher_key, watcher in var.watchers : [
        for fl_key, fl in watcher.flowlogs : {
          watcher_key          = watcher_key
          fl_key               = fl_key
          flowlog              = fl
          watcher              = watcher
          use_existing_watcher = watcher.use_existing_watcher
        }
      ]
    ]) : "${fl.watcher_key}.${fl.fl_key}" => fl
  }

  name = coalesce(
    each.value.flowlog.name,
    try(var.naming.network_watcher_flow_log, null),
    "${each.value.watcher_key}-${each.value.fl_key}"
  )

  resource_group_name = coalesce(
    each.value.flowlog.resource_group_name,
    each.value.watcher.resource_group_name,
    var.resource_group_name
  )

  location = coalesce(
    each.value.flowlog.location,
    each.value.watcher.location,
    var.location
  )

  network_watcher_name = each.value.use_existing_watcher ? data.azurerm_network_watcher.existing_watcher[each.value.watcher_key].name : azurerm_network_watcher.watcher[each.value.watcher_key].name
  target_resource_id   = each.value.flowlog.target_resource_id

  storage_account_id = coalesce(
    each.value.flowlog.storage_account_id,
    each.value.watcher.storage_account_id
  )

  enabled = each.value.flowlog.enabled
  version = each.value.flowlog.version

  tags = coalesce(
    each.value.flowlog.tags,
    var.tags
  )

  retention_policy {
    enabled = each.value.flowlog.retention_policy.enabled
    days    = each.value.flowlog.retention_policy.days
  }

  dynamic "traffic_analytics" {
    for_each = each.value.flowlog.traffic_analytics != null ? [each.value.flowlog.traffic_analytics] : []

    content {
      enabled               = traffic_analytics.value.enabled
      workspace_id          = traffic_analytics.value.workspace_id
      workspace_region      = traffic_analytics.value.workspace_region
      workspace_resource_id = traffic_analytics.value.workspace_resource_id
      interval_in_minutes   = traffic_analytics.value.interval_in_minutes
    }
  }
}
