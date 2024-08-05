locals {

  watchers = {
    for watcher_key, watcher in var.watchers : watcher_key => {
      name                 = watcher.name
      resource_group       = try(watcher.resource_group, var.resource_group)
      location             = try(watcher.location, var.location)
      use_existing_watcher = try(watcher.use_existing_watcher, false)
      tags                 = try(watcher.tags, var.tags, null)
    }
  }

  flowlogs = flatten([
    for watcher_key, watcher in var.watchers : [
      for fl_key, fl in lookup(watcher, "flowlogs", {}) : {


        watcher_key               = watcher_key
        fl_key                    = fl_key
        flowlog_name              = try(fl.name, join("-", [var.naming.network_watcher, fl_key]))
        resource_group            = try(fl.resource_group, watcher.resource_group, var.resource_group)
        location                  = try(fl.location, watcher.location, var.location)
        network_security_group_id = fl.network_security_group_id
        storage_account_id        = coalesce(lookup(var.watchers, "storage_account_id", null), fl.storage_account_id)

        enabled                  = try(fl.enabled, true)
        version                  = try(fl.version, null)
        retention_policy_enabled = try(fl.retention_policy.enabled, false)
        retention_policy_days    = try(fl.retention_policy.days, 7)
        traffic_analytics        = try(fl.traffic_analytics, null)
        use_existing_watcher     = try(watcher.use_existing_watcher, false)
        tags                     = try(fl.tags, var.tags, null)
      }
    ]
  ])
}
