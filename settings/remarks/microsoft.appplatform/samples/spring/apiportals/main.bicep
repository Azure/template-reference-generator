param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource spring 'Microsoft.AppPlatform/Spring@2023-05-01-preview' = {
  name: resourceName
  location: location
  sku: {
    name: 'E0'
  }
  properties: {
    zoneRedundant: false
  }
}

resource apiPortal 'Microsoft.AppPlatform/Spring/apiPortals@2023-05-01-preview' = {
  name: 'default'
  parent: spring
  sku: {
    capacity: 1
    name: 'E0'
    tier: 'Enterprise'
  }
  properties: {
    gatewayIds: []
    httpsOnly: false
    public: false
  }
}
