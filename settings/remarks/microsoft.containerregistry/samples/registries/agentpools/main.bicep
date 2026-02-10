param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource registry 'Microsoft.ContainerRegistry/registries@2021-08-01-preview' = {
  name: resourceName
  location: location
  sku: {
    name: 'Premium'
    tier: 'Premium'
  }
  properties: {
    dataEndpointEnabled: false
    encryption: {
      status: 'disabled'
    }
    networkRuleBypassOptions: 'AzureServices'
    policies: {
      trustPolicy: {
        status: 'disabled'
      }
      exportPolicy: {
        status: 'enabled'
      }
      quarantinePolicy: {
        status: 'disabled'
      }
      retentionPolicy: {
        status: 'disabled'
      }
    }
    publicNetworkAccess: 'Enabled'
    adminUserEnabled: false
    zoneRedundancy: 'Disabled'
    anonymousPullEnabled: false
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
