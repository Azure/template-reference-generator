param resourceName string = 'acctest0001'
param location string = 'westus'

resource registry 'Microsoft.ContainerRegistry/registries@2023-11-01-preview' = {
  name: '${resourceName}registry'
  location: location
  properties: {
    adminUserEnabled: false
    anonymousPullEnabled: false
    dataEndpointEnabled: true
    networkRuleBypassOptions: 'AzureServices'
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
  }
  sku: {
    name: 'Premium'
  }
}

resource connectedRegistry 'Microsoft.ContainerRegistry/registries/connectedRegistries@2023-11-01-preview' = {
  parent: registry
  name: '${resourceName}connectedregistry'
  properties: {
    clientTokenIds: null
    logging: {
      auditLogStatus: 'Disabled'
      logLevel: 'None'
    }
    mode: 'ReadWrite'
    parent: {
      syncProperties: {
        messageTtl: 'P1D'
        schedule: '* * * * *'
        syncWindow: ''
        tokenId: token.id
      }
    }
  }
}

resource scopeMap 'Microsoft.ContainerRegistry/registries/scopeMaps@2023-11-01-preview' = {
  parent: registry
  name: '${resourceName}scopemap'
  properties: {
    actions: [
      'repositories/hello-world/content/delete'
      'repositories/hello-world/content/read'
      'repositories/hello-world/content/write'
      'repositories/hello-world/metadata/read'
      'repositories/hello-world/metadata/write'
      'gateway/acctest0001connectedregistry/config/read'
      'gateway/acctest0001connectedregistry/config/write'
      'gateway/acctest0001connectedregistry/message/read'
      'gateway/acctest0001connectedregistry/message/write'
    ]
    description: ''
  }
}

resource token 'Microsoft.ContainerRegistry/registries/tokens@2023-11-01-preview' = {
  parent: registry
  name: '${resourceName}token'
  properties: {
    scopeMapId: scopeMap.id
    status: 'enabled'
  }
}
