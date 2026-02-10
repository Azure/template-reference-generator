param resourceName string = 'acctest0001'
param location string = 'westus'

resource registry 'Microsoft.ContainerRegistry/registries@2023-11-01-preview' = {
  name: '${resourceName}registry'
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    policies: {
      exportPolicy: {
        status: 'enabled'
      }
      quarantinePolicy: {
        status: 'disabled'
      }
      retentionPolicy: {}
      trustPolicy: {}
    }
    publicNetworkAccess: 'Enabled'
    zoneRedundancy: 'Disabled'
    adminUserEnabled: false
    anonymousPullEnabled: false
    dataEndpointEnabled: false
    networkRuleBypassOptions: 'AzureServices'
  }
}

resource cacheRule 'Microsoft.ContainerRegistry/registries/cacheRules@2023-07-01' = {
  name: '${resourceName}-cache-rule'
  parent: registry
  properties: {
    sourceRepository: 'mcr.microsoft.com/hello-world'
    targetRepository: 'target'
  }
}
