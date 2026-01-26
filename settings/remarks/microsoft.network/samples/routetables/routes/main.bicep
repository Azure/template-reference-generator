param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource routeTable 'Microsoft.Network/routeTables@2022-09-01' = {
  name: resourceName
  location: location
  properties: {
    disableBgpRoutePropagation: false
  }
}

resource route 'Microsoft.Network/routeTables/routes@2022-09-01' = {
  parent: routeTable
  name: resourceName
  properties: {
    addressPrefix: '10.1.0.0/16'
    nextHopType: 'VnetLocal'
  }
}
