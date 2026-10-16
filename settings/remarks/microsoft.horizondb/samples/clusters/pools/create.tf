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

variable "pool_name" {
  type        = string
  default     = "example-pool-01"
  description = "The name of the HorizonDB pool"
}

data "azapi_client_config" "current" {
}

resource "azapi_resource" "pools" {
  type      = "Microsoft.HorizonDb/clusters/pools@2026-10-01-preview"
  name      = var.pool_name
  parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}/resourceGroups/${data.azapi_client_config.current.resource_group_name}/providers/Microsoft.HorizonDb/clusters/${var.cluster_name}"

  body = {
    properties = {
      computeModel = {
        type = "Provisioned"
        computeProcessor = "AMD"
        computeGeneration = 3
        vCores = 2
      }
      parameterGroup = {
        parameterGroupResourceId = "/subscriptions/ffffffff-ffff-ffff-ffff-ffffffffffff/providers/Microsoft.HorizonDb/locations/eastus2/parameterGroups/default-postgresql-17-provisioned"
        applyMethod = "Immediate"
      }
      scheduledMaintenance = {
        maintenanceManagementType = "System"
      }
      nodeCount = 1
      highAvailability = {
        mode = "Disabled"
      }
    }
  }

  schema_validation_enabled = false
  response_export_values    = ["*"]
}
