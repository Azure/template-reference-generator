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
  description = "The name for the parameter group"
}

variable "location" {
  type        = string
  default     = "eastus"
  description = "The location for the parameter group"
}

variable "tags" {
  type = object({
    env         = optional(string)
  })
  default = {
    env  = "dev"
  }
  description = "The tags for the parameter group"
}

variable "pg_version" {
  type        = number
  default     = 17
  description = "The PostgreSQL version for the parameter group"
}

variable "apply_immediately" {
  type        = bool
  default     = true
  description = "Whether to apply changes immediately"
}

variable "parameter_group_description" {
  type        = string
  default     = "Parameter group for high-throughput workloads"
  description = "The description of the parameter group"
}

variable "parameters" {
  type = list(object({
    name  = string
    value = string
  }))
  default = [
    {
      name  = "max_connections"
      value = "200"
    },
    {
      name  = "log_min_error_statement"
      value = "error"
    },
    {
      name  = "shared_buffers"
      value = "2000"
    }
  ]
  description = "The database parameters for the parameter group"
}

data "azapi_client_config" "current" {
}

resource "azapi_resource" "parameter_group" {
  type      = "Microsoft.HorizonDB/parameterGroups@2026-01-20-preview"
  name      = var.parameter_group_name
  location  = var.location
  parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}/resourceGroups/${data.azapi_client_config.current.resource_group_name}"

  body = {
    tags = var.tags
    properties = {
      parameters = var.parameters
      description      = var.parameter_group_description
      pgVersion        = var.pg_version
      applyImmediately = var.apply_immediately
    }
  }

  schema_validation_enabled = false
  response_export_values    = ["*"]
}
