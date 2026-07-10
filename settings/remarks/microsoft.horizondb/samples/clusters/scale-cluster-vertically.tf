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

variable "location" {
  type        = string
  default     = "eastus"
  description = "The location for the cluster"
}

variable "cluster_name" {
  type        = string
  description = "The name for the cluster"
}

variable "create_mode" {
  type        = string
  default     = "Update"
  description = "The create mode for cluster"
}

variable "v_cores" {
  type        = number
  default     = 8
  description = "The number of vCores for each replica of the cluster"
}

resource "azapi_resource" "cluster" {
  type      = "Microsoft.HorizonDB/clusters@2026-01-20-preview"
  name      = var.cluster_name
  location  = var.location
  parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}/resourceGroups/${data.azapi_client_config.current.resource_group_name}"

  body = {
    properties = {
      createMode = var.create_mode
      vCores     = var.v_cores
    }
  }

  schema_validation_enabled = false
  response_export_values    = ["*"]
}

data "azapi_client_config" "current" {
}
