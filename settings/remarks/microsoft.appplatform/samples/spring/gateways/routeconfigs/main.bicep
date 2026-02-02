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

resource app 'Microsoft.AppPlatform/Spring/apps@2023-05-01-preview' = {
  parent: spring
  name: resourceName
  location: location
  properties: {
    customPersistentDisks: []
    enableEndToEndTLS: false
    public: false
  }
}

resource gateway 'Microsoft.AppPlatform/Spring/gateways@2023-05-01-preview' = {
  parent: spring
  name: 'default'
  properties: {
    httpsOnly: false
    public: false
  }
  sku: {
    capacity: 1
    name: 'E0'
    tier: 'Enterprise'
  }
}

resource routeConfig 'Microsoft.AppPlatform/Spring/gateways/routeConfigs@2023-05-01-preview' = {
  parent: gateway
  name: resourceName
  properties: {
    appResourceId: app.id
    protocol: 'HTTP'
    routes: []
    ssoEnabled: false
  }
}
