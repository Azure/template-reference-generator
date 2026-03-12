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
  sku: {
    capacity: 0
    name: 'Consumption'
  }
  properties: {
    customProperties: {
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls11': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls10': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls11': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Ssl30': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls10': 'false'
    }
    disableGateway: false
    publicNetworkAccess: 'Enabled'
    publisherEmail: 'pub1@email.com'
    publisherName: 'pub1'
    virtualNetworkType: 'None'
    certificates: []
  }
}

resource openidConnectProvider 'Microsoft.ApiManagement/service/openidConnectProviders@2021-08-01' = {
  name: resourceName
  parent: service
  properties: {
    clientId: '${openidClientId}'
    clientSecret: '${openidClientSecret}'
    description: ''
    displayName: 'Initial Name'
    metadataEndpoint: 'https://azacceptance.hashicorptest.com/example/foo'
  }
}
