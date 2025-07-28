# Flowlogs

This deploys the utilization of log analytics workspace for traffic analytics.

## Types

```hcl
watcher = object({
  name           = string
  resource_group = string
  location       = string
  flowlogs = optional(map(object({
    target_resource_id         = string
    storage_account_id         = string
    traffic_analytics = optional(object({
      workspace_id          = string
      workspace_resource_id = string
      workspace_region      = string
      workspace_key         = string
    }))
  })))
})
```