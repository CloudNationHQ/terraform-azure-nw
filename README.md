# Network Watcher

This terraform module simplifies the process of creating and managing network watcher (flow logs) on azure with customizable options and features, offering a flexible and powerful solution for managing network watchers through code.

## Features

- Support for multiple network watchers
- Allows multiple flow logs per network watcher
- Utilization of terratest for robust validation
- Provides support for utilizing existing network watchers.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.11 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.37.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_network_watcher.watcher](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher) | resource |
| [azurerm_network_watcher_flow_log.watcher_flowlog](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log) | resource |
| [azurerm_network_watcher.existing_watcher](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/network_watcher) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | default azure region to be used. | `string` | `null` | no |
| <a name="input_naming"></a> [naming](#input\_naming) | Used for naming purposes | `map(string)` | `null` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | default resource group to be used. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | tags to be added to the resources | `map(string)` | `{}` | no |
| <a name="input_watchers"></a> [watchers](#input\_watchers) | network watcher configuration | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_flowlog"></a> [flowlog](#output\_flowlog) | contains all network watcher flow log details |
| <a name="output_watcher"></a> [watcher](#output\_watcher) | contains network watcher details |
<!-- END_TF_DOCS -->

## Goals

For more information, please see our [goals and non-goals](./GOALS.md).

## Testing

For more information, please see our testing [guidelines](./TESTING.md)

## Notes

By default, Network Watchers are automatically created by Azure, upon deployment of a Virtual Network in that same region. In addition, only one Network Watcher per subscription for each region can be deployed. Therefore, if you want to manage the Network Watcher through Terraform, you can either opt out automatic enablement of Network Watcher [by using the AZ CLI or PowerShell](https://learn.microsoft.com/en-us/azure/network-watcher/network-watcher-create?tabs=portal#opt-out-of-network-watcher-automatic-enablement) or use the `use_existing_watcher` flag.

### Example: Using `use_existing_watcher` for West Europe

```hcl
  watcher = {
    name                 = "NetworkWatcher_westeurope"
    resource_group       = "NetworkWatcherRG"
    use_existing_watcher = true
  }
```

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
