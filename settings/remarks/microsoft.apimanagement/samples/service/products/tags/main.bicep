param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource service 'Microsoft.ApiManagement/service@2021-08-01' = {
  name: resourceName
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

resource serviceTag 'Microsoft.ApiManagement/service/tags@2021-08-01' = {
  name: resourceName
  parent: service
  properties: {
    displayName: '${resourceName}'
  }
}

resource product 'Microsoft.ApiManagement/service/products@2021-08-01' = {
  name: resourceName
  parent: service
  properties: {
    description: ''
    displayName: 'Test Product'
    state: 'notPublished'
    subscriptionRequired: false
    terms: ''
  }
}

resource tag 'Microsoft.ApiManagement/service/products/tags@2021-08-01' = {
  name: 'azapi_resource.service_tag.name'
  parent: product
}
