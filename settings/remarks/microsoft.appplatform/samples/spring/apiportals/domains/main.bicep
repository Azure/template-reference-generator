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
    tier: 'Enterprise'
    capacity: 1
    name: 'E0'
  }
  properties: {
    httpsOnly: false
    public: false
    gatewayIds: []
  }
}

resource domain 'Microsoft.AppPlatform/Spring/apiPortals/domains@2023-05-01-preview' = {
  name: '${resourceName}.azuremicroservices.io'
  parent: apiPortal
  properties: {
    thumbprint: ''
  }
}
