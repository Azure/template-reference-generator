param location string = 'westeurope'
param resourceName string = 'acctest0001'

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

resource configurationService 'Microsoft.AppPlatform/Spring/configurationServices@2023-05-01-preview' = {
  name: 'default'
  parent: spring
  properties: {
    settings: {
      gitProperty: {}
    }
  }
}
