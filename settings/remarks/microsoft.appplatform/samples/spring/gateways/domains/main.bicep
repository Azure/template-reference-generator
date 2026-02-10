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

resource gateway 'Microsoft.AppPlatform/Spring/gateways@2023-05-01-preview' = {
  name: 'default'
  parent: spring
  sku: {
    capacity: 1
    name: 'E0'
    tier: 'Enterprise'
  }
  properties: {
    httpsOnly: false
    public: false
  }
}

resource domain 'Microsoft.AppPlatform/Spring/gateways/domains@2023-05-01-preview' = {
  name: '${resourceName}.azuremicroservices.io'
  parent: gateway
  properties: {
    thumbprint: ''
  }
}
