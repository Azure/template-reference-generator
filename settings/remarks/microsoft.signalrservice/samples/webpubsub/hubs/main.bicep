param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource webPubSub 'Microsoft.SignalRService/webPubSub@2023-02-01' = {
  name: resourceName
  location: location
  properties: {
    disableAadAuth: false
    disableLocalAuth: false
    publicNetworkAccess: 'Enabled'
    tls: {
      clientCertEnabled: false
    }
  }
  sku: {
    capacity: 1
    name: 'Standard_S1'
  }
}

resource hub 'Microsoft.SignalRService/webPubSub/hubs@2023-02-01' = {
  parent: webPubSub
  name: resourceName
  properties: {
    anonymousConnectPolicy: 'Deny'
    eventListeners: []
  }
}
