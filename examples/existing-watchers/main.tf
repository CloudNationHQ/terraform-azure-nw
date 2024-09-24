module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.1"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 2.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name
      location = "westeurope"
    }
  }
}

module "storage" {
  source  = "cloudnationhq/sa/azure"
  version = "~> 2.0"

  storage = {
    name           = module.naming.storage_account.name_unique
    location       = module.rg.groups.demo.location
    resource_group = module.rg.groups.demo.name
  }
}

module "network" {
  source  = "cloudnationhq/vnet/azure"
  version = "~> 4.0"

  naming = local.naming

  vnet = {
    name           = module.naming.virtual_network.name
    cidr           = ["10.18.0.0/16"]
    location       = module.rg.groups.demo.location
    resource_group = module.rg.groups.demo.name

    subnets = {
      sn1 = {
        cidr = ["10.18.1.0/24"]
        nsg  = {}
      }
    }
  }
}

module "watcher" {
  source  = "cloudnationhq/nw/azure"
  version = "~> 1.0"

  watchers = {
    watcher = {
      name           = "NetworkWatcher_westeurope"
      location       = "westeurope"
      resource_group = "NetworkWatcherRG"

      use_existing_watcher = true

      flowlogs = {
        flowlog = {
          name                      = module.naming.network_watcher_flow_log.name
          network_security_group_id = module.network.nsg.sn1.id
          storage_account_id        = module.storage.account.id
        }
      }
    }
  }
}


