param resourceName string = 'acctest0001'
param location string = 'westus'

resource namespace 'Microsoft.EventGrid/namespaces@2023-12-15-preview' = {
  name: '${resourceName}-ns'
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
  }
  sku: {
    capacity: 1
    name: 'Standard'
  }
}
