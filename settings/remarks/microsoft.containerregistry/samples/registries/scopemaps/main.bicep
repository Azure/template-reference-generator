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
    zoneRedundancy: 'Disabled'
    adminUserEnabled: false
    anonymousPullEnabled: false
    networkRuleBypassOptions: 'AzureServices'
    policies: {
      retentionPolicy: {
        status: 'disabled'
      }
      trustPolicy: {
        status: 'disabled'
      }
      exportPolicy: {
        status: 'enabled'
      }
      quarantinePolicy: {
        status: 'disabled'
      }
    }
    publicNetworkAccess: 'Enabled'
    dataEndpointEnabled: false
    encryption: {
      status: 'disabled'
    }
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
