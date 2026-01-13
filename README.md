# Network Watcher

This terraform module simplifies the process of creating and managing network watcher (flow logs) on azure with customizable options and features, offering a flexible and powerful solution for managing network watchers through code.

## Features

Multiple network watchers support

Multiple flow logs per watcher

Existing watcher integration

Traffic analytics with log analytics workspace

Configurable retention policies

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 4.11)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (~> 4.11)

## Resources

The following resources are used by this module:

- [azurerm_network_watcher.watcher](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher) (resource)
- [azurerm_network_watcher_flow_log.watcher_flowlog](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log) (resource)
- [azurerm_network_watcher.existing_watcher](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/network_watcher) (data source)

## Required Inputs

The following input variables are required:

### <a name="input_watchers"></a> [watchers](#input\_watchers)

Description: network watcher configuration

Type:

```hcl
map(object({
    name                 = string
    resource_group_name  = optional(string)
    location             = optional(string)
    use_existing_watcher = optional(bool, false)
    storage_account_id   = optional(string)
    tags                 = optional(map(string))
    flowlogs = optional(map(object({
      name                = optional(string)
      resource_group_name = optional(string)
      location            = optional(string)
      target_resource_id  = string
      storage_account_id  = optional(string)
      enabled             = optional(bool, true)
      version             = optional(number)
      tags                = optional(map(string))
      retention_policy = optional(object({
        enabled = optional(bool, false)
        days    = optional(number, 7)
      }), {})
      traffic_analytics = optional(object({
        enabled               = optional(bool, true)
        workspace_id          = string
        workspace_region      = string
        workspace_resource_id = string
        interval_in_minutes   = optional(number, 60)
      }))
    })), {})
  }))
```

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_location"></a> [location](#input\_location)

Description: default azure region to be used.

Type: `string`

Default: `null`

### <a name="input_naming"></a> [naming](#input\_naming)

Description: Used for naming purposes

Type: `map(string)`

Default: `null`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: default resource group to be used.

Type: `string`

Default: `null`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: tags to be added to the resources

Type: `map(string)`

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_flowlog"></a> [flowlog](#output\_flowlog)

Description: contains all network watcher flow log details

### <a name="output_watcher"></a> [watcher](#output\_watcher)

Description: contains network watcher details
<!-- END_TF_DOCS -->

## Goals

For more information, please see our [goals and non-goals](./GOALS.md).

## Testing

For more information, please see our testing [guidelines](./TESTING.md)

## Notes

Using a dedicated module, we've developed a naming convention for resources that's based on specific regular expressions for each type, ensuring correct abbreviations and offering flexibility with multiple prefixes and suffixes.

Full examples detailing all usages, along with integrations with dependency modules, are located in the examples directory.

To update the module's documentation run `make doc`

## Authors

Module is maintained by [these awesome contributors](https://github.com/cloudnationhq/terraform-azure-nw/graphs/contributors).

## Contributors

We welcome contributions from the community! Whether it's reporting a bug, suggesting a new feature, or submitting a pull request, your input is highly valued.

For more information, please see our contribution [guidelines](./CONTRIBUTING.md). <br><br>

<a href="https://github.com/cloudnationhq/terraform-azure-nw/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=cloudnationhq/terraform-azure-nw" />
</a>

## License

MIT Licensed. See [LICENSE](./LICENSE) for full details.

## References

- [Documentation](https://learn.microsoft.com/en-us/azure/network-watcher/network-watcher-overview)
- [Rest Api](https://learn.microsoft.com/en-us/rest/api/network-watcher/)
