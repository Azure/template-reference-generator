terraform {
  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
  }
}

provider "azapi" {
  skip_provider_registration = false
}

variable "cluster_name" {
  type        = string
  description = "The name for the cluster"
}

variable "location" {
  type        = string
  default     = "eastus"
  description = "The location for the cluster"
}

variable "administrator_login" {
  type        = string
  description = "The administrator login name for cluster"
}

variable "administrator_login_password" {
  type        = string
  description = "The administrator login password for cluster"
  sensitive   = true
}

variable "create_mode" {
  type        = string
  default     = "Create"
  description = "The create mode for cluster"
}

variable "version" {
  type        = number
  default     = 17
  description = "The major version of server"
}

variable "v_cores" {
  type        = number
  default     = 4
  description = "The number of vCores for each replica of the cluster"
}

variable "replica_count" {
  type        = number
  default     = 2
  description = "The number of replicas for the cluster, including the primary replica, which is the only one in which writes are allowed. The other replicas are read-only."
}

variable "zone_placement_policy" {
  type        = string
  default     = "BestEffort"
  description = "The name of the SKU for cluster"
}

variable "tags" {
  type = object({
    env = optional(string)
  })
  default = {
    env = "dev"
  }
  description = "The tags for the cluster"
}

resource "azapi_resource" "cluster" {
  type      = "Microsoft.HorizonDB/clusters@2026-01-20-preview"
  name      = var.cluster_name
  location  = var.location
  parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}/resourceGroups/${data.azapi_client_config.current.resource_group_name}"

  body = {
    tags = var.tags
    properties = {
      createMode               = var.create_mode
      version                  = var.version
      administratorLogin       = var.administrator_login
      administratorLoginPassword = var.administrator_login_password
      vCores                   = var.v_cores
      replicaCount             = var.replica_count
      zonePlacementPolicy      = var.zone_placement_policy
    }
  }

  schema_validation_enabled = false
  response_export_values    = ["*"]
}

data "azapi_client_config" "current" {
}
