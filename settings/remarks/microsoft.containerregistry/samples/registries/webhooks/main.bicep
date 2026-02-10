param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource registry 'Microsoft.ContainerRegistry/registries@2021-08-01-preview' = {
  name: resourceName
  location: location
  sku: {
    tier: 'Standard'
    name: 'Standard'
  }
  properties: {
    encryption: {
      status: 'disabled'
    }
    networkRuleBypassOptions: 'AzureServices'
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
    adminUserEnabled: false
    anonymousPullEnabled: false
    dataEndpointEnabled: false
  }
}

resource webHook 'Microsoft.ContainerRegistry/registries/webHooks@2021-08-01-preview' = {
  name: resourceName
  location: location
  parent: registry
  properties: {
    actions: [
      'push'
    ]
    customHeaders: {}
    scope: ''
    serviceUri: 'https://mywebhookreceiver.example/mytag'
    status: 'enabled'
  }
}
