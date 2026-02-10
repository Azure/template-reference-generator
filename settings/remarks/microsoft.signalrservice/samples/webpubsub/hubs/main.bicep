param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource webPubSub 'Microsoft.SignalRService/webPubSub@2023-02-01' = {
  name: resourceName
  location: location
  sku: {
    capacity: 1
    name: 'Standard_S1'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
    tls: {
      clientCertEnabled: false
    }
    disableAadAuth: false
    disableLocalAuth: false
  }
}

resource hub 'Microsoft.SignalRService/webPubSub/hubs@2023-02-01' = {
  name: resourceName
  parent: webPubSub
  properties: {
    anonymousConnectPolicy: 'Deny'
    eventListeners: []
  }
}
