param resourceName string = 'acctest0001'
param location string = 'westus'

resource service 'Microsoft.ApiManagement/service@2022-08-01' = {
  name: '${resourceName}-am'
  location: location
  sku: {
    name: 'Consumption'
    capacity: 0
  }
  properties: {
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
    publicNetworkAccess: 'Enabled'
    publisherEmail: 'pub1@email.com'
    publisherName: 'pub1'
  }
}

resource api 'Microsoft.ApiManagement/service/apis@2022-08-01' = {
  name: '${resourceName}-api;rev=1'
  parent: service
  properties: {
    subscriptionRequired: true
    apiRevisionDescription: ''
    apiVersionDescription: ''
    displayName: 'Butter Parser'
    protocols: [
      'http'
      'https'
    ]
    type: 'http'
    apiType: 'http'
    authenticationSettings: {}
    description: 'What is my purpose? You parse butter.'
    path: 'butter-parser'
    serviceUrl: 'https://example.com/foo/bar'
    subscriptionKeyParameterNames: {
      header: 'X-Butter-Robot-API-Key'
      query: 'location'
    }
  }
}

resource operation 'Microsoft.ApiManagement/service/apis/operations@2022-08-01' = {
  name: '${resourceName}-operation'
  parent: api
  properties: {
    urlTemplate: '/resource'
    description: ''
    displayName: 'DELETE Resource'
    method: 'DELETE'
    responses: []
    templateParameters: []
  }
}
