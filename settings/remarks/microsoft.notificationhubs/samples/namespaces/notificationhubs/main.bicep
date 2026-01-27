param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource namespace 'Microsoft.NotificationHubs/namespaces@2017-04-01' = {
  name: resourceName
  location: location
  properties: {
    enabled: true
    namespaceType: 'NotificationHub'
    region: 'westeurope'
  }
  sku: {
    name: 'Free'
  }
}

resource notificationHub 'Microsoft.NotificationHubs/namespaces/notificationHubs@2017-04-01' = {
  parent: namespace
  name: resourceName
  location: location
  properties: {}
}
