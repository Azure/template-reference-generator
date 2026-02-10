param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource webPubSub 'Microsoft.SignalRService/webPubSub@2023-02-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_S1'
    capacity: 1
  }
  properties: {
    disableLocalAuth: false
    publicNetworkAccess: 'Enabled'
    tls: {
      clientCertEnabled: false
    }
    disableAadAuth: false
  }
}
