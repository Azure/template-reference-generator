param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource dashboard 'Microsoft.Portal/dashboards@2019-01-01-preview' = {
  name: resourceName
  location: location
  properties: {
    lenses: {}
  }
}
