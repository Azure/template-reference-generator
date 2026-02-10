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
    anonymousPullEnabled: false
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
    adminUserEnabled: true
    dataEndpointEnabled: false
    encryption: {
      status: 'disabled'
    }
    publicNetworkAccess: 'Enabled'
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
