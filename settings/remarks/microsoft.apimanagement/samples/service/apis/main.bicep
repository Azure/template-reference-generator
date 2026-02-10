param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource service 'Microsoft.ApiManagement/service@2021-08-01' = {
  name: resourceName
  location: location
  sku: {
    capacity: 0
    name: 'Consumption'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
    publisherEmail: 'pub1@email.com'
    publisherName: 'pub1'
    virtualNetworkType: 'None'
    certificates: []
    customProperties: {
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Ssl30': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls10': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls11': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls10': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls11': 'false'
    }
    disableGateway: false
  }
}

resource api 'Microsoft.ApiManagement/service/apis@2021-08-01' = {
  name: '${resourceName};rev=1'
  parent: service
  properties: {
    path: 'api1'
    protocols: [
      'https'
    ]
    authenticationSettings: {}
    description: ''
    serviceUrl: ''
    subscriptionRequired: true
    type: 'http'
    apiRevisionDescription: ''
    apiType: 'http'
    apiVersion: ''
    apiVersionDescription: ''
    displayName: 'api1'
  }
}
