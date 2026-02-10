param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource service 'Microsoft.ApiManagement/service@2021-08-01' = {
  name: resourceName
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

resource product 'Microsoft.ApiManagement/service/products@2021-08-01' = {
  name: resourceName
  parent: service
  properties: {
    state: 'notPublished'
    subscriptionRequired: false
    terms: ''
    description: ''
    displayName: 'Test Product'
  }
}

resource policy2 'Microsoft.ApiManagement/service/products/policies@2021-08-01' = {
  name: 'policy'
  parent: product
  properties: {
    format: 'rawxml-link'
    value: 'https://gist.githubusercontent.com/riordanp/ca22f8113afae0eb38cc12d718fd048d/raw/d6ac89a2f35a6881a7729f8cb4883179dc88eea1/example.xml'
  }
}
