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
    publicNetworkAccess: 'Enabled'
    anonymousPullEnabled: false
    dataEndpointEnabled: false
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
    zoneRedundancy: 'Disabled'
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
