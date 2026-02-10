param location string = 'westus'
param resourceName string = 'acctest0001'

resource service 'Microsoft.ApiManagement/service@2022-08-01' = {
  name: '${resourceName}-am'
  location: location
  sku: {
    capacity: 0
    name: 'Consumption'
  }
  properties: {
    customProperties: {
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls10': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls11': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls10': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls11': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Ssl30': 'false'
    }
    disableGateway: false
    publicNetworkAccess: 'Enabled'
    publisherEmail: 'pub1@email.com'
    publisherName: 'pub1'
    virtualNetworkType: 'None'
    certificates: []
  }
}

resource api 'Microsoft.ApiManagement/service/apis@2022-08-01' = {
  name: '${resourceName}-api;rev=1'
  parent: service
  properties: {
    description: 'What is my purpose? You parse butter.'
    protocols: [
      'http'
      'https'
    ]
    serviceUrl: 'https://example.com/foo/bar'
    subscriptionKeyParameterNames: {
      header: 'X-Butter-Robot-API-Key'
      query: 'location'
    }
    apiType: 'http'
    authenticationSettings: {}
    displayName: 'Butter Parser'
    path: 'butter-parser'
    subscriptionRequired: true
    type: 'http'
    apiRevisionDescription: ''
    apiVersionDescription: ''
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
