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

variable "log_capture_configuration_name" {
  type        = string
  default     = "PostgreSqlServer"
  description = "The name of the log capture configuration"
}

data "azapi_client_config" "current" {
}

resource "azapi_update_resource" "log_capture_configurations" {
  type      = "Microsoft.HorizonDb/clusters/logCaptureConfigurations@2026-10-01-preview"
  name      = var.log_capture_configuration_name
  parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}/resourceGroups/${data.azapi_client_config.current.resource_group_name}/providers/Microsoft.HorizonDb/clusters/${var.cluster_name}"

  body = {
    properties = {
      state = "Disabled"
    }
  }

  schema_validation_enabled = false
  response_export_values    = ["*"]
}
