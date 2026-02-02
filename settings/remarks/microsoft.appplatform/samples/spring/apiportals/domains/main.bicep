param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource spring 'Microsoft.AppPlatform/Spring@2023-05-01-preview' = {
  name: resourceName
  location: location
  properties: {
    zoneRedundant: false
  }
  sku: {
    name: 'E0'
  }
}

resource apiPortal 'Microsoft.AppPlatform/Spring/apiPortals@2023-05-01-preview' = {
  parent: spring
  name: 'default'
  properties: {
    gatewayIds: []
    httpsOnly: false
    public: false
  }
  sku: {
    capacity: 1
    name: 'E0'
    tier: 'Enterprise'
  }
}

resource domain 'Microsoft.AppPlatform/Spring/apiPortals/domains@2023-05-01-preview' = {
  parent: apiPortal
  name: '${resourceName}.azuremicroservices.io'
  properties: {
    thumbprint: ''
  }
}
