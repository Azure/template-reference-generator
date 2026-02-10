param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource namespace 'Microsoft.NotificationHubs/namespaces@2017-04-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Free'
  }
  properties: {
    region: 'westeurope'
    enabled: true
    namespaceType: 'NotificationHub'
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
