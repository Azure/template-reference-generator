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

variable "assignment_name" {
  type        = string
  default     = "fabric-writer"
  description = "The name of the identity assignment"
}

data "azapi_client_config" "current" {
}

resource "azapi_resource" "identity_assignments" {
  type      = "Microsoft.HorizonDb/clusters/changeDataCaptureDestinations/identityAssignments@2026-10-01-preview"
  name      = var.assignment_name
  parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}/resourceGroups/${data.azapi_client_config.current.resource_group_name}/providers/Microsoft.HorizonDb/clusters/${var.cluster_name}/changeDataCaptureDestinations/${var.destination_name}"

  body = {
    properties = {
      identityResourceId = "/subscriptions/ffffffff-ffff-ffff-ffff-ffffffffffff/resourceGroups/identity-resource-group/providers/Microsoft.ManagedIdentity/userAssignedIdentities/fabric-writer"
    }
  }

  schema_validation_enabled = false
  response_export_values    = ["*"]
}
