# Complete

This example highlights the complete usage.

## Types

```hcl
watchers = object({
  name           = string
  resource_group = string
  location       = string
  flowlogs = optional(map(object({
    network_security_group_id  = string
    storage_account_id         = string
    retention_policy_days      = optional(number)
    version                    = optional(number)
    traffic_analytics          = optional(object({
      workspace_id = string
      workspace_region      = string
      workspace_resource_id = string
      enabled               = optional(bool)
    }))
    retention_policy = optional(object({
      days    = number
      enabled = bool
    }))
  })))
})
```

## Notes

You can also utilize an existing watcher by setting use_existing_watcher = true.
