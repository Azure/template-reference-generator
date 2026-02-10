param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource routeTable 'Microsoft.Network/routeTables@2022-09-01' = {
  name: resourceName
  location: location
  properties: {
    disableBgpRoutePropagation: false
    routes: [
      {
        name: 'first'
        properties: {
          addressPrefix: '10.100.0.0/14'
          nextHopIpAddress: '10.10.1.1'
          nextHopType: 'VirtualAppliance'
        }
      }
    ]
  }
}
