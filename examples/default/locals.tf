locals {
  naming = {
    # lookup outputs to have consistent naming
    for type in local.naming_types : type => lookup(module.naming, type).name
  }

  naming_types = ["subnet", "network_security_group", "network_watcher", "network_watcher_flow_log", "log_analytics_workspace", "virtual_network", "storage_account", "resource_group"]
}

locals {
  rules = {
    myhttps = {
      name                       = "myhttps"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.151.1.0/24"
      destination_address_prefix = "*"
    }
    mysql = {
      name                       = "mysql"
      priority                   = 200
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_ranges    = ["3306", "3307"]
      source_address_prefixes    = ["10.0.0.0/24", "11.0.0.0/24"]
      destination_address_prefix = "*"
    }
  }
}
