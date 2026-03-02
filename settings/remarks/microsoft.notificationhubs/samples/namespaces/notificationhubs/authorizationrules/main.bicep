param location string = 'westeurope'
param resourceName string = 'acctest0001'

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

resource notificationHub 'Microsoft.NotificationHubs/namespaces/notificationHubs@2017-04-01' = {
  name: resourceName
  location: location
  parent: namespace
  properties: {}
}

resource authorizationRule 'Microsoft.NotificationHubs/namespaces/notificationHubs/authorizationRules@2017-04-01' = {
  name: resourceName
  parent: notificationHub
  properties: {
    rights: [
      'Listen'
    ]
  }
}
