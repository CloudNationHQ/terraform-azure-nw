# Flowlogs

When a virtual network is created for the first time in a specific region, Azure creates a network watcher by default. This example shows how this module can be used to leverage an existing network watcher.

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

## Notes

To disable the automatic craetion of network watchers by Azure, you can follow the steps on this page: https://learn.microsoft.com/en-us/azure/network-watcher/network-watcher-create?tabs=portal
