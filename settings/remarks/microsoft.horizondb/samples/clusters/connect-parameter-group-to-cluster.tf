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

variable "parameter_group_id" {
  type        = string
  description = "The identifier of the parameter group to connect to the cluster"
}

resource "azapi_resource" "cluster" {
  type      = "Microsoft.HorizonDB/clusters@2026-01-20-preview"
  name      = var.cluster_name
  location  = var.location
  parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}/resourceGroups/${data.azapi_client_config.current.resource_group_name}"

  body = {
    properties = {
      createMode = var.create_mode
      parameterGroup = {
        id = var.parameter_group_id
      }
    }
  }

  schema_validation_enabled = false
  response_export_values    = ["*"]
}

data "azapi_client_config" "current" {
}
