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

data "azapi_client_config" "current" {
}

resource "azapi_resource" "authentications" {
  type      = "Microsoft.HorizonDb/clusters/authentications@2026-10-01-preview"
  name      = "microsoftEntra"
  parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}/resourceGroups/${data.azapi_client_config.current.resource_group_name}/providers/Microsoft.HorizonDb/clusters/${var.cluster_name}"

  body = {
    properties = {
      state = "Disabled"
    }
  }

  schema_validation_enabled = false
  response_export_values    = ["*"]
}
