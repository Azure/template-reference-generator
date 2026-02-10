param location string = 'westus'
param resourceName string = 'acctest0001'

resource namespace 'Microsoft.EventGrid/namespaces@2023-12-15-preview' = {
  name: '${resourceName}-ns'
  location: location
  sku: {
    capacity: 1
    name: 'Standard'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}
