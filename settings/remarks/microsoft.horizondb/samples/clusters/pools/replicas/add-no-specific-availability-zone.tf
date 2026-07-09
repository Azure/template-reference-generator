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
  description = "The name for the cluster"
}

variable "pool_name" {
  type        = string
  default     = "DefaultPool"
  description = "The name for the pool"
}

variable "replica_name" {
  type        = string
  description = "The name for the replica"
}

variable "role" {
  type        = string
  default     = "Read"
  description = "The role for the replica"
}

data "azapi_client_config" "current" {
}

resource "azapi_resource" "replica" {
  type      = "Microsoft.HorizonDB/clusters/pools/replicas@2026-01-20-preview"
  name      = var.replica_name
  parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}/resourceGroups/${data.azapi_client_config.current.resource_group_name}/providers/Microsoft.HorizonDB/clusters/${var.cluster_name}/pools/${var.pool_name}"

  body = {
    properties = {
      role             = var.role
    }
  }

  schema_validation_enabled = false
  response_export_values    = ["*"]
}


variable "cluster_name" {
  type        = string
  description = "The name for the cluster"
}

variable "pool_name" {
  type        = string
  default     = "DefaultPool"
  description = "The name for the pool"
}

variable "firewall_rule_name" {
  type        = string
  default     = "DataAnalyticsDepartment"
  description = "The name for the firewall rule"
}

variable "firewall_rule_start_ip" {
  type        = string
  default     = "10.0.0.1"
  description = "The start IP address for the firewall rule"
}

variable "firewall_rule_end_ip" {
  type        = string
  default     = "10.0.0.10"
  description = "The end IP address for the firewall rule"
}

variable "firewall_rule_description" {
  type        = string
  default     = "Allow all IP addresses from the Data Analytics department"
  description = "The description for the firewall rule"
}

variable "administrator_login" {
  type        = string
  description = "The administrator login name for cluster"
}

variable "administrator_login_password" {
  type        = string
  description = "The administrator login password for cluster"
  sensitive   = true
}

variable "create_mode" {
  type        = string
  default     = "Create"
  description = "The create mode for cluster"
}

variable "version" {
  type        = number
  default     = 17
  description = "The major version of server"
}

variable "v_cores" {
  type        = number
  default     = 4
  description = "The number of vCores for each replica of the cluster"
}

variable "replica_count" {
  type        = number
  default     = 2
  description = "The number of replicas for the cluster, including the primary replica, which is the only one in which writes are allowed. The other replicas are read-only."
}

variable "zone_placement_policy" {
  type        = string
  default     = "BestEffort"
  description = "The name of the SKU for cluster"
}

data "azapi_client_config" "current" {
}

resource "azapi_resource" "cluster" {
  type      = "Microsoft.HorizonDB/clusters@2026-01-20-preview"
  name      = var.cluster_name
  parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}/resourceGroups/${data.azapi_client_config.current.resource_group_name}"

  body = {
    properties = {
      createMode               = var.create_mode
      version                  = var.version
      administratorLogin       = var.administrator_login
      administratorLoginPassword = var.administrator_login_password
      vCores                   = var.v_cores
      replicaCount             = var.replica_count
      zonePlacementPolicy      = var.zone_placement_policy
    }
  }

  schema_validation_enabled = false
  response_export_values    = ["*"]
}

resource "azapi_resource" "firewall_rule" {
  type      = "Microsoft.HorizonDB/clusters/pools/firewallRules@2026-01-20-preview"
  parent_id = "${azapi_resource.cluster.id}/pools/${var.pool_name}"
  name      = var.firewall_rule_name

  body = {
    properties = {
      startIp     = var.firewall_rule_start_ip
      endIp       = var.firewall_rule_end_ip
      description = var.firewall_rule_description
    }
  }

  schema_validation_enabled = false
  response_export_values    = ["*"]
}

