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

variable "parameter_group_name" {
  type        = string
  default     = "production-parameters"
  description = "The name of the parameter group"
}

data "azapi_client_config" "current" {
}

resource "azapi_update_resource" "parameter_groups" {
  type      = "Microsoft.HorizonDb/parameterGroups@2026-10-01-preview"
  name      = var.parameter_group_name
  parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}/resourceGroups/${data.azapi_client_config.current.resource_group_name}/providers/Microsoft.HorizonDb"

  body = {
    tags = {
      environment = "production"
      team = "data-platform"
    }
    properties = {
      parameters = [
        {
          name = "application_name"
          value = "horizondb-production"
        },
        {
          name = "autovacuum"
          value = "off"
        },
        {
          name = "wal_receiver_timeout"
          value = "45000"
        },
        {
          name = "work_mem"
          value = "8192"
        },
        {
          name = "xmlbinary"
          value = "base64"
        },
      ]
      description = "Updated parameters for production transactional workloads"
    }
  }

  schema_validation_enabled = false
  response_export_values    = ["*"]
}
