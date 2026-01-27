param resourceName string = 'acctest0001'
param location string = 'eastus'

resource dataBoxEdgeDevice 'Microsoft.DataBoxEdge/dataBoxEdgeDevices@2022-03-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'EdgeP_Base'
    tier: 'Standard'
  }
}
