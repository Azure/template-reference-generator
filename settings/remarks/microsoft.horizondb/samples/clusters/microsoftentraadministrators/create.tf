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

variable "object_id" {
  type        = string
  default     = "11111111-1111-1111-1111-111111111111"
  description = "The object ID of the Microsoft Entra administrator"
}

data "azapi_client_config" "current" {
}

resource "azapi_resource" "microsoft_entra_administrators" {
  type      = "Microsoft.HorizonDb/clusters/microsoftEntraAdministrators@2026-10-01-preview"
  name      = var.object_id
  parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}/resourceGroups/${data.azapi_client_config.current.resource_group_name}/providers/Microsoft.HorizonDb/clusters/${var.cluster_name}"

  body = {
    properties = {
      principalName = "database.administrators@contoso.com"
      principalType = "Group"
      tenantId = "22222222-2222-2222-2222-222222222222"
    }
  }

  schema_validation_enabled = false
  response_export_values    = ["*"]
}
