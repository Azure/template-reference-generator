param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource registry 'Microsoft.ContainerRegistry/registries@2021-08-01-preview' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
  properties: {
    networkRuleBypassOptions: 'AzureServices'
    policies: {
      quarantinePolicy: {
        status: 'disabled'
      }
      retentionPolicy: {
        status: 'disabled'
      }
      trustPolicy: {
        status: 'disabled'
      }
      exportPolicy: {
        status: 'enabled'
      }
    }
    publicNetworkAccess: 'Enabled'
    zoneRedundancy: 'Disabled'
    anonymousPullEnabled: false
    adminUserEnabled: false
    dataEndpointEnabled: false
    encryption: {
      status: 'disabled'
    }
  }
}

resource webHook 'Microsoft.ContainerRegistry/registries/webHooks@2021-08-01-preview' = {
  name: resourceName
  location: location
  parent: registry
  properties: {
    scope: ''
    serviceUri: 'https://mywebhookreceiver.example/mytag'
    status: 'enabled'
    actions: [
      'push'
    ]
    customHeaders: {}
  }
}
