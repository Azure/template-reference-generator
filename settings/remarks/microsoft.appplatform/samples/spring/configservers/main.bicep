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

resource configServer 'Microsoft.AppPlatform/Spring/configServers@2023-05-01-preview' = {
  parent: spring
  name: 'default'
  properties: {
    configServer: {}
  }
}
