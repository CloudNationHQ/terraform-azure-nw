variable "watchers" {
  description = "network watcher configuration"
  type = map(object({
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
}

variable "naming" {
  description = "Used for naming purposes"
  type        = map(string)
  default     = null
}

variable "location" {
  description = "default azure region to be used."
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "default resource group to be used."
  type        = string
  default     = null
}

variable "tags" {
  description = "tags to be added to the resources"
  type        = map(string)
  default     = {}
}
