param resourceName string = 'acctest0001'
param location string = 'westus'

resource service 'Microsoft.ApiManagement/service@2022-08-01' = {
  name: '${resourceName}-service'
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

resource api 'Microsoft.ApiManagement/service/apis@2022-08-01' = {
  parent: service
  name: '${resourceName}-api;rev=1'
  properties: {
    apiRevisionDescription: ''
    apiType: 'http'
    apiVersionDescription: ''
    authenticationSettings: {}
    displayName: 'api1'
    path: 'api1'
    protocols: [
      'https'
    ]
    subscriptionRequired: true
    type: 'http'
  }
}

resource tag 'Microsoft.ApiManagement/service/tags@2022-08-01' = {
  parent: service
  name: '${resourceName}-tag'
  properties: {
    displayName: 'acctest0001-tag'
  }
}

resource tagDescription 'Microsoft.ApiManagement/service/apis/tagDescriptions@2022-08-01' = {
  parent: api
  name: '${resourceName}-tag'
  properties: {
    description: 'tag description'
    externalDocsDescription: 'external tag description'
    externalDocsUrl: 'https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs'
  }
}

resource tag1 'Microsoft.ApiManagement/service/apis/tags@2022-08-01' = {
  parent: api
  name: '${resourceName}-tag'
}
