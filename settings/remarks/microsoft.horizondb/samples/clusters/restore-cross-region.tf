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
  default     = "cross-region-restored-cluster"
  description = "The name of the HorizonDB cluster"
}

data "azapi_client_config" "current" {
}

resource "azapi_resource" "clusters" {
  type      = "Microsoft.HorizonDb/clusters@2026-10-01-preview"
  name      = var.cluster_name
  parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}/resourceGroups/${data.azapi_client_config.current.resource_group_name}/providers/Microsoft.HorizonDb"
  location  = "westus2"

  body = {
    properties = {
      creationMode = "PointInTimeRestore"
      pointInTimeUtc = "2026-07-27T12:00:00Z"
      creationSourceClusterResourceId = "/subscriptions/ffffffff-ffff-ffff-ffff-ffffffffffff/resourceGroups/example-resource-group/providers/Microsoft.HorizonDb/clusters/source-cluster"
      creationSourceClusterLocation = "eastus2"
      network = {
        publicAccess = "Disabled"
      }
      backup = {
        geoRedundancy = "Enabled"
        retentionDays = 14
      }
    }
  }

  schema_validation_enabled = false
  response_export_values    = ["*"]
}
