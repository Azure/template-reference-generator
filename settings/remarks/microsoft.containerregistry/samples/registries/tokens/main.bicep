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
    networkRuleBypassOptions: 'AzureServices'
    publicNetworkAccess: 'Enabled'
    adminUserEnabled: true
    dataEndpointEnabled: false
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
    encryption: {
      status: 'disabled'
    }
  }
}

resource token 'Microsoft.ContainerRegistry/registries/tokens@2021-08-01-preview' = {
  name: resourceName
  parent: registry
  properties: {
    scopeMapId: resourceId('Microsoft.ContainerRegistry/registries/scopeMaps', registry.name, '_repositories_pull')
    status: 'enabled'
  }
}
