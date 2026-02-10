param resourceName string = 'acctest0001'
param location string = 'westus'

resource service 'Microsoft.ApiManagement/service@2022-08-01' = {
  name: '${resourceName}-service'
  location: location
  sku: {
    capacity: 0
    name: 'Consumption'
  }
  properties: {
    publisherName: 'pub1'
    virtualNetworkType: 'None'
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
  }
}

resource api 'Microsoft.ApiManagement/service/apis@2022-08-01' = {
  name: '${resourceName}-api;rev=1'
  parent: service
  properties: {
    apiRevisionDescription: ''
    apiType: 'http'
    apiVersionDescription: ''
    authenticationSettings: {}
    displayName: 'api1'
    protocols: [
      'https'
    ]
    subscriptionRequired: true
    path: 'api1'
    type: 'http'
  }
}

resource tag 'Microsoft.ApiManagement/service/tags@2022-08-01' = {
  name: '${resourceName}-tag'
  parent: service
  properties: {
    displayName: '${resourceName}-tag'
  }
}

resource tagDescription 'Microsoft.ApiManagement/service/apis/tagDescriptions@2022-08-01' = {
  name: '${resourceName}-tag'
  parent: api
  properties: {
    description: 'tag description'
    externalDocsDescription: 'external tag description'
    externalDocsUrl: 'https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs'
  }
}

resource tag1 'Microsoft.ApiManagement/service/apis/tags@2022-08-01' = {
  name: '${resourceName}-tag'
  parent: api
}
