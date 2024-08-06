# Flowlogs

This deploys one or more flowlogs within an existing network watcher

## Types

```hcl
watcher = object({
  name           = string
  resource_group = string
  location       = string

  use_existing_watcher = optional(bool)
  flowlogs = optional(map(object({
    network_security_group_id  = string
    storage_account_id         = string
  })))
})
```