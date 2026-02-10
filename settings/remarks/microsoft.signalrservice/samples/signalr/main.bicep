param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource signalR 'Microsoft.SignalRService/signalR@2023-02-01' = {
  name: resourceName
  location: location
  sku: {
    capacity: 1
    name: 'Standard_S1'
  }
  properties: {
    disableAadAuth: false
    features: [
      {
        flag: 'ServiceMode'
        value: 'Default'
      }
      {
        flag: 'EnableConnectivityLogs'
        value: 'False'
      }
      {
        flag: 'EnableMessagingLogs'
        value: 'False'
      }
      {
        value: 'False'
        flag: 'EnableLiveTrace'
      }
    ]
    publicNetworkAccess: 'Enabled'
    serverless: {
      connectionTimeoutInSeconds: 30
    }
    cors: {}
    disableLocalAuth: false
    resourceLogConfiguration: {
      categories: [
        {
          enabled: 'false'
          name: 'MessagingLogs'
        }
        {
          enabled: 'false'
          name: 'ConnectivityLogs'
        }
        {
          enabled: 'false'
          name: 'HttpRequestLogs'
        }
      ]
    }
    tls: {
      clientCertEnabled: false
    }
    upstream: {
      templates: []
    }
  }
}
