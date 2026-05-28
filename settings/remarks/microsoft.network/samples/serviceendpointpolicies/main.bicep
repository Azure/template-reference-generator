param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource serviceEndpointPolicy 'Microsoft.Network/serviceEndpointPolicies@2022-07-01' = {
  name: resourceName
  location: location
  properties: {}
}
