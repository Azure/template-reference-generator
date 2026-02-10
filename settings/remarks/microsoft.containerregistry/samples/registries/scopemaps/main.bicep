param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource registry 'Microsoft.ContainerRegistry/registries@2021-08-01-preview' = {
  name: resourceName
  location: location
  sku: {
    tier: 'Premium'
    name: 'Premium'
  }
  properties: {
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
    adminUserEnabled: false
    anonymousPullEnabled: false
    dataEndpointEnabled: false
    publicNetworkAccess: 'Enabled'
    encryption: {
      status: 'disabled'
    }
    networkRuleBypassOptions: 'AzureServices'
  }
}

resource scopeMap 'Microsoft.ContainerRegistry/registries/scopeMaps@2021-08-01-preview' = {
  name: resourceName
  parent: registry
  properties: {
    actions: [
      'repositories/testrepo/content/read'
    ]
    description: ''
  }
}
