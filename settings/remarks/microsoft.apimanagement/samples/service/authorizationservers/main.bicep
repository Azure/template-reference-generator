param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The OAuth client ID for the authorization server')
param oauthClientId string
@secure()
@description('The OAuth client secret for the authorization server')
param oauthClientSecret string

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

resource authorizationServer 'Microsoft.ApiManagement/service/authorizationServers@2021-08-01' = {
  name: resourceName
  parent: service
  properties: {
    clientAuthenticationMethod: []
    clientRegistrationEndpoint: 'https://azacceptance.hashicorptest.com/client/register'
    clientSecret: '${oauthClientSecret}'
    defaultScope: ''
    grantTypes: [
      'implicit'
    ]
    resourceOwnerPassword: ''
    supportState: false
    authorizationMethods: [
      'GET'
    ]
    clientId: '${oauthClientId}'
    description: ''
    displayName: 'Test Group'
    resourceOwnerUsername: ''
    tokenBodyParameters: []
    authorizationEndpoint: 'https://azacceptance.hashicorptest.com/client/authorize'
  }
}
