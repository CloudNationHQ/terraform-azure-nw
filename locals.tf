locals {
  flowlogs = flatten([
    for nwfl_key, nwfl in try(var.nwatcher.flowlogs, {}) : {

      nwfl_key                  = nwfl_key
      flowlog_name              = try(nwfl.name, join("-", [var.naming.network_watcher, nwfl_key]))
      network_watcher_name      = azurerm.network_watcher.nwatcher.name
      network_security_group_id = nwfl.network_security_group_id
      storage_account_id        = coalesce(lookup(var.nwatcher, "storage_account_id", null), nwfl.storage_account_id)

      enabled                  = try(nwfl.enabled, true)
      version                  = try(nwfl.version, null)
      retention_policy_enabled = try(nwfl.retention_policy.enabled, false)
      retention_policy_days    = try(nwfl.retention_policy.days, 7)
      traffic_analytics        = try(nwfl.traffic_analytics, null)
      tags                     = try(nwfl.tags, var.tags, null)
    }
  ])
}
