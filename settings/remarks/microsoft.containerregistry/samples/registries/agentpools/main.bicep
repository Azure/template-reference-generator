param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource registry 'Microsoft.ContainerRegistry/registries@2021-08-01-preview' = {
  name: resourceName
  location: location
  sku: {
    name: 'Premium'
    tier: 'Premium'
  }
  properties: {
    dataEndpointEnabled: false
    networkRuleBypassOptions: 'AzureServices'
    adminUserEnabled: false
    anonymousPullEnabled: false
    encryption: {
      status: 'disabled'
    }
    policies: {
      exportPolicy: {
        status: 'enabled'
      }
      quarantinePolicy: {
        status: 'disabled'
      }
      retentionPolicy: {
        status: 'disabled'
      }
      trustPolicy: {
        status: 'disabled'
      }
    }
    publicNetworkAccess: 'Enabled'
    zoneRedundancy: 'Disabled'
  }
}

resource agentPool 'Microsoft.ContainerRegistry/registries/agentPools@2019-06-01-preview' = {
  name: resourceName
  location: location
  parent: registry
  properties: {
    count: 1
    os: 'Linux'
    tier: 'S1'
  }
}
