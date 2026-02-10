param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource routeFilter 'Microsoft.Network/routeFilters@2022-09-01' = {
  name: resourceName
  location: location
  properties: {
    rules: []
  }
}
