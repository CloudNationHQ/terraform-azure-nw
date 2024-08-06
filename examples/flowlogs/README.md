# Flowlogs

This deploys one or more flowlogs within the network watcher

## Types

```hcl
watcher = object({
  name          = string
  resource_group = string
  location      = string
  flowlogs = optional(map(object({
    network_security_group_id  = string
    storage_account_id = string
  })))
})
```