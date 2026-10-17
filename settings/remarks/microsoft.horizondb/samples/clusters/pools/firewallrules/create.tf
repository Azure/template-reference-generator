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

variable "firewall_rule_name" {
  type        = string
  default     = "example-firewall-rule-01"
  description = "The name of the firewall rule"
}

data "azapi_client_config" "current" {
}

resource "azapi_resource" "firewall_rules" {
  type      = "Microsoft.HorizonDb/clusters/pools/firewallRules@2026-10-01-preview"
  name      = var.firewall_rule_name
  parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}/resourceGroups/${data.azapi_client_config.current.resource_group_name}/providers/Microsoft.HorizonDb/clusters/${var.cluster_name}/pools/${var.pool_name}"

  body = {
    properties = {
      startIpAddress = "10.0.0.1"
      endIpAddress = "10.0.0.254"
      description = "Allow access from the corporate network"
    }
  }

  schema_validation_enabled = false
  response_export_values    = ["*"]
}
