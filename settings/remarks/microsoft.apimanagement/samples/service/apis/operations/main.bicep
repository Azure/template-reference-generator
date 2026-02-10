param resourceName string = 'acctest0001'
param location string = 'westus'

resource service 'Microsoft.ApiManagement/service@2022-08-01' = {
  name: '${resourceName}-am'
  location: location
  sku: {
    capacity: 0
    name: 'Consumption'
  }
  properties: {
    disableGateway: false
    publicNetworkAccess: 'Enabled'
    publisherEmail: 'pub1@email.com'
    publisherName: 'pub1'
    virtualNetworkType: 'None'
    certificates: []
    customProperties: {
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls10': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls11': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Ssl30': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls10': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls11': 'false'
    }
  }
}

resource api 'Microsoft.ApiManagement/service/apis@2022-08-01' = {
  name: '${resourceName}-api;rev=1'
  parent: service
  properties: {
    description: 'What is my purpose? You parse butter.'
    displayName: 'Butter Parser'
    path: 'butter-parser'
    protocols: [
      'http'
      'https'
    ]
    subscriptionRequired: true
    type: 'http'
    apiRevisionDescription: ''
    apiType: 'http'
    serviceUrl: 'https://example.com/foo/bar'
    subscriptionKeyParameterNames: {
      header: 'X-Butter-Robot-API-Key'
      query: 'location'
    }
    apiVersionDescription: ''
    authenticationSettings: {}
  }
}

resource operation 'Microsoft.ApiManagement/service/apis/operations@2022-08-01' = {
  name: '${resourceName}-operation'
  parent: api
  properties: {
    description: ''
    displayName: 'DELETE Resource'
    method: 'DELETE'
    responses: []
    templateParameters: []
    urlTemplate: '/resource'
  }
}
