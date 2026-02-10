param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource namespace 'Microsoft.NotificationHubs/namespaces@2017-04-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Free'
  }
  properties: {
    enabled: true
    namespaceType: 'NotificationHub'
    region: 'westeurope'
  }
}
