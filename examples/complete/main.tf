module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.1"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 0.1"

  groups = {
    demo = {
      name   = module.naming.resource_group.name
      region = "westeurope"
    }
  }
}

module "storage" {
  source  = "cloudnationhq/sa/azure"
  version = "~> 0.1"

  storage = {
    name          = module.naming.storage_account.name_unique
    location      = module.rg.groups.demo.location
    resourcegroup = module.rg.groups.demo.name
  }
}

module "network" {
  source  = "cloudnationhq/vnet/azure"
  version = "~> 2.7"

  naming = local.naming

  vnet = {
    name          = module.naming.virtual_network.name
    cidr          = ["10.18.0.0/16"]
    location      = module.rg.groups.demo.location
    resourcegroup = module.rg.groups.demo.name

    subnets = {
      sn1 = {
        cidr = ["10.18.1.0/24"]
        nsg = {
          rules = local.rules
        }
      }
    }
  }
}

module "analytics" {
  source  = "cloudnationhq/law/azure"
  version = "~> 0.1"

  law = {
    name          = module.naming.log_analytics_workspace.name
    location      = module.rg.groups.demo.location
    resourcegroup = module.rg.groups.demo.name
  }
}

module "watcher" {
  source = "../.."

  watchers = {
    watcher = {
      name           = module.naming.network_watcher.name
      location       = module.rg.groups.demo.location
      resource_group = module.rg.groups.demo.name

      use_existing_watcher = false

      flowlogs = {
        flowlog = {
          name                      = module.naming.network_watcher_flow_log.name
          network_security_group_id = module.network.nsg.sn1.id
          storage_account_id        = module.storage.account.id
          retention_policy_days     = 7
          traffic_analytics = {
            enabled               = true
            workspace_id          = module.analytics.workspace.workspace_id
            workspace_region      = module.rg.groups.demo.location
            workspace_resource_id = module.analytics.workspace.id
          }
        }
      }
    }
    watcher = {
      name                 = "NetworkWatcher_Existing"
      use_existing_watcher = true
      location             = module.rg.groups.demo.location
      resource_group       = module.rg.groups.demo.name

      flowlogs = {
        flowlog = {
          name                      = module.naming.network_watcher_flow_log.name
          network_security_group_id = module.network.nsg.sn1.id
          storage_account_id        = module.storage.account.id
          retention_policy_days     = 7
          traffic_analytics = {
            enabled               = true
            workspace_id          = module.analytics.workspace.workspace_id
            workspace_region      = module.rg.groups.demo.location
            workspace_resource_id = module.analytics.workspace.id
          }
        }
      }
    }
  }
}


