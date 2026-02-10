param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource routeTable 'Microsoft.Network/routeTables@2022-09-01' = {
  name: resourceName
  location: location
  properties: {
    disableBgpRoutePropagation: false
  }
}

resource route 'Microsoft.Network/routeTables/routes@2022-09-01' = {
  name: resourceName
  parent: routeTable
  properties: {
    nextHopType: 'VnetLocal'
    addressPrefix: '10.1.0.0/16'
  }
}
