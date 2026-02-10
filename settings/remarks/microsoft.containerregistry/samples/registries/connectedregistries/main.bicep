param location string = 'westus'
param resourceName string = 'acctest0001'

resource registry 'Microsoft.ContainerRegistry/registries@2023-11-01-preview' = {
  name: '${resourceName}registry'
  location: location
  sku: {
    name: 'Premium'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
    zoneRedundancy: 'Disabled'
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
  }
}

resource connectedRegistry 'Microsoft.ContainerRegistry/registries/connectedRegistries@2023-11-01-preview' = {
  name: '${resourceName}connectedregistry'
  parent: registry
  properties: {
    clientTokenIds: null
    logging: {
      auditLogStatus: 'Disabled'
      logLevel: 'None'
    }
    mode: 'ReadWrite'
    parent: {
      syncProperties: {
        syncWindow: ''
        messageTtl: 'P1D'
        schedule: '* * * * *'
      }
    }
  }
}

resource scopeMap 'Microsoft.ContainerRegistry/registries/scopeMaps@2023-11-01-preview' = {
  name: '${resourceName}scopemap'
  parent: registry
  properties: {
    actions: [
      'repositories/hello-world/content/delete'
      'repositories/hello-world/content/read'
      'repositories/hello-world/content/write'
      'repositories/hello-world/metadata/read'
      'repositories/hello-world/metadata/write'
      'gateway/${resourceName}connectedregistry/config/read'
      'gateway/${resourceName}connectedregistry/config/write'
      'gateway/${resourceName}connectedregistry/message/read'
      'gateway/${resourceName}connectedregistry/message/write'
    ]
    description: ''
  }
}

resource token 'Microsoft.ContainerRegistry/registries/tokens@2023-11-01-preview' = {
  name: '${resourceName}token'
  parent: registry
  properties: {
    scopeMapId: scopeMap.id
    status: 'enabled'
  }
}
