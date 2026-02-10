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
    adminUserEnabled: false
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
    zoneRedundancy: 'Disabled'
    anonymousPullEnabled: false
    dataEndpointEnabled: false
    networkRuleBypassOptions: 'AzureServices'
    publicNetworkAccess: 'Enabled'
  }
}

resource agentPool 'Microsoft.ContainerRegistry/registries/agentPools@2019-06-01-preview' = {
  name: resourceName
  location: location
  parent: registry
  properties: {
    os: 'Linux'
    tier: 'S1'
    count: 1
  }
}
