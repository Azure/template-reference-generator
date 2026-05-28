param resourceName string = 'acctest0001'
param location string = 'westus'

resource trafficController 'Microsoft.ServiceNetworking/trafficControllers@2023-11-01' = {
  name: resourceName
  location: location
}

resource frontend 'Microsoft.ServiceNetworking/trafficControllers/frontends@2023-11-01' = {
  name: '${resourceName}-frontend'
  location: location
  parent: trafficController
  properties: {}
}
