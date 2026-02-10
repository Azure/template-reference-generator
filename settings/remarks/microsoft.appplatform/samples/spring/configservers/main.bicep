param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource spring 'Microsoft.AppPlatform/Spring@2023-05-01-preview' = {
  name: resourceName
  location: location
  sku: {
    name: 'S0'
  }
  properties: {
    zoneRedundant: false
  }
}

resource configServer 'Microsoft.AppPlatform/Spring/configServers@2023-05-01-preview' = {
  name: 'default'
  parent: spring
  properties: {
    configServer: {}
  }
}
