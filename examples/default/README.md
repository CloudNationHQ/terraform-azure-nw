This example illustrates the default setup, in its simplest form.

## Notes

By default, network watchers are automatically created by Azure, upon deployment of a virtual network in that same region. In addition, only one per subscription for each region can be deployed.

Therefore, if you want to manage it through terraform, you can either opt out automatic enablement of network watcher [by using the AZ CLI or PowerShell](https://learn.microsoft.com/en-us/azure/network-watcher/network-watcher-create?tabs=portal#opt-out-of-network-watcher-automatic-enablement) or use the `use_existing_watcher` flag.

```hcl
  watcher = {
    name                 = "NetworkWatcher_westeurope"
    resource_group_name  = "NetworkWatcherRG"
    use_existing_watcher = true
  }
```
