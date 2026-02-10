param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource routeFilter 'Microsoft.Network/routeFilters@2022-09-01' = {
  name: resourceName
  location: location
  properties: {
    rules: []
  }
}
