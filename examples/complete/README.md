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
    traffic_analytics          = optional(object({
      workspace_id = string
    }))
    retention_policy = optional(object({
      days = number
      enabled = bool
    }))
  })))
})
```
