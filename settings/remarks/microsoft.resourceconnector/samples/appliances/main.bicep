param resourceName string = 'acctest0001'
param location string = 'westus'

resource appliance 'Microsoft.ResourceConnector/appliances@2022-10-27' = {
  name: '${resourceName}-appliance'
  location: location
  properties: {
    distro: 'AKSEdge'
    infrastructureConfig: {
      provider: 'VMWare'
    }
  }
}
