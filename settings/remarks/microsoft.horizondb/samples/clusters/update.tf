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

resource "azapi_update_resource" "clusters" {
  type      = "Microsoft.HorizonDb/clusters@2026-10-01-preview"
  name      = var.cluster_name
  parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}/resourceGroups/${data.azapi_client_config.current.resource_group_name}/providers/Microsoft.HorizonDb"

  body = {
    tags = {
      environment = "production"
      team = "data-platform"
    }
    properties = {
      network = {
        publicAccess = "Disabled"
      }
      backup = {
        retentionDays = 21
      }
    }
  }

  schema_validation_enabled = false
  response_export_values    = ["*"]
}
