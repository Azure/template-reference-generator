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

resource applicationLiveView 'Microsoft.AppPlatform/Spring/applicationLiveViews@2023-05-01-preview' = {
  parent: spring
  name: 'default'
}
