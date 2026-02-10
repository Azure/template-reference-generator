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

resource api 'Microsoft.ApiManagement/service/apis@2021-08-01' = {
  name: '${resourceName};rev=1'
  parent: service
  properties: {
    type: 'http'
    apiRevisionDescription: ''
    apiType: 'http'
    apiVersion: ''
    apiVersionDescription: ''
    description: ''
    displayName: 'api1'
    path: 'api1'
    protocols: [
      'https'
    ]
    authenticationSettings: {}
    serviceUrl: ''
    subscriptionRequired: true
  }
}

resource policy 'Microsoft.ApiManagement/service/apis/policies@2021-08-01' = {
  name: 'policy'
  parent: api
  properties: {
    format: 'xml'
    value: '''<policies>
  <inbound>
    <set-variable name="abc" value="@(context.Request.Headers.GetValueOrDefault(&quot;X-Header-Name&quot;, &quot;&quot;))" />
    <find-and-replace from="xyz" to="abc" />
  </inbound>
</policies>
'''
  }
}
