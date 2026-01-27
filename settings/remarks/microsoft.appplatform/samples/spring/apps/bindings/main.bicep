param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource spring 'Microsoft.AppPlatform/Spring@2023-05-01-preview' = {
  name: resourceName
  location: location
  properties: {
    zoneRedundant: false
  }
  sku: {
    name: 'S0'
  }
}

resource redis 'Microsoft.Cache/redis@2023-04-01' = {
  name: resourceName
  location: location
  properties: {
    enableNonSslPort: true
    minimumTlsVersion: '1.2'
    sku: {
      capacity: 2
      family: 'C'
      name: 'Standard'
    }
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

resource binding 'Microsoft.AppPlatform/Spring/apps/bindings@2023-05-01-preview' = {
  parent: app
  name: resourceName
  properties: {
    bindingParameters: {
      useSsl: 'true'
    }
    key: 'redis.listKeys().primaryKey'
    resourceId: redis.id
  }
}
