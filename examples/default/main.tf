module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.22"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 2.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name_unique
      location = "southeastasia"
    }
  }
}

module "storage" {
  source  = "cloudnationhq/sa/azure"
  version = "~> 3.0"

  storage = {
    name           = module.naming.storage_account.name_unique
    location       = module.rg.groups.demo.location
    resource_group = module.rg.groups.demo.name
  }
}

module "network" {
  source  = "cloudnationhq/vnet/azure"
  version = "~> 8.0"

  naming = local.naming

  vnet = {
    name           = module.naming.virtual_network.name
    address_space  = ["10.18.0.0/16"]
    location       = module.rg.groups.demo.location
    resource_group = module.rg.groups.demo.name

    subnets = {
      sn1 = {
        address_prefixes       = ["10.18.1.0/24"]
        network_security_group = {}
      }
    }
  }
}

module "watcher" {
  source  = "cloudnationhq/nw/azure"
  version = "~> 1.0"

  watchers = {
    watcher = {
      name           = module.naming.network_watcher.name
      location       = module.rg.groups.demo.location
      resource_group = module.rg.groups.demo.name
    }
  }
}
