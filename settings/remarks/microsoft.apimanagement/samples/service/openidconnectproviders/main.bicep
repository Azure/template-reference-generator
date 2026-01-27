param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The client ID for the OpenID Connect provider')
param openidClientId string
@secure()
@description('The client secret for the OpenID Connect provider')
param openidClientSecret string

resource service 'Microsoft.ApiManagement/service@2021-08-01' = {
  name: resourceName
  location: location
  properties: {
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
    virtualNetworkType: 'None'
  }
  sku: {
    capacity: 0
    name: 'Consumption'
  }
}

resource openidConnectProvider 'Microsoft.ApiManagement/service/openidConnectProviders@2021-08-01' = {
  parent: service
  name: resourceName
  properties: {
    clientId: null
    clientSecret: null
    description: ''
    displayName: 'Initial Name'
    metadataEndpoint: 'https://azacceptance.hashicorptest.com/example/foo'
  }
}
