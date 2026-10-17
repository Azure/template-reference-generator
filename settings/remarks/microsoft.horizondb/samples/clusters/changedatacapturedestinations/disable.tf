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
  default     = "example-cluster"
  description = "The name of the HorizonDB cluster"
}

variable "destination_name" {
  type        = string
  default     = "fabric-mirroring"
  description = "The name of the change data capture destination"
}

data "azapi_client_config" "current" {
}

resource "azapi_update_resource" "change_data_capture_destinations" {
  type      = "Microsoft.HorizonDb/clusters/changeDataCaptureDestinations@2026-10-01-preview"
  name      = var.destination_name
  parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}/resourceGroups/${data.azapi_client_config.current.resource_group_name}/providers/Microsoft.HorizonDb/clusters/${var.cluster_name}"

  body = {
    properties = {
      desiredState = "Disabled"
    }
  }

  schema_validation_enabled = false
  response_export_values    = ["*"]
}
