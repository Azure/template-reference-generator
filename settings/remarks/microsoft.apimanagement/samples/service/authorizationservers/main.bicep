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
}

resource authorizationServer 'Microsoft.ApiManagement/service/authorizationServers@2021-08-01' = {
  name: resourceName
  parent: service
  properties: {
    authorizationEndpoint: 'https://azacceptance.hashicorptest.com/client/authorize'
    authorizationMethods: [
      'GET'
    ]
    clientAuthenticationMethod: []
    clientId: oauthClientId
    clientRegistrationEndpoint: 'https://azacceptance.hashicorptest.com/client/register'
    clientSecret: oauthClientSecret
    defaultScope: ''
    description: ''
    displayName: 'Test Group'
    grantTypes: [
      'implicit'
    ]
    resourceOwnerPassword: ''
    resourceOwnerUsername: ''
    supportState: false
    tokenBodyParameters: []
  }
}
