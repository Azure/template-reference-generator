param resourceName string = 'acctest0001'
param location string = 'westus'

resource service 'Microsoft.ApiManagement/service@2022-08-01' = {
  name: '${resourceName}-service'
  location: location
  sku: {
    name: 'Consumption'
    capacity: 0
  }
  properties: {
    certificates: []
    customProperties: {
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls11': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Ssl30': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls10': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls11': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls10': 'false'
    }
    disableGateway: false
    publicNetworkAccess: 'Enabled'
    publisherEmail: 'pub1@email.com'
    publisherName: 'pub1'
    virtualNetworkType: 'None'
  }
}

resource api 'Microsoft.ApiManagement/service/apis@2022-08-01' = {
  name: '${resourceName}-api;rev=1'
  parent: service
  properties: {
    displayName: 'api1'
    protocols: [
      'https'
    ]
    apiType: 'http'
    apiVersionDescription: ''
    path: 'api1'
    subscriptionRequired: true
    type: 'http'
    apiRevisionDescription: ''
    authenticationSettings: {}
  }
}

resource tag 'Microsoft.ApiManagement/service/tags@2022-08-01' = {
  name: '${resourceName}-tag'
  parent: service
  properties: {
    displayName: '${resourceName}-tag'
  }
}
