param resourceName string = 'acctest0001'
param location string = 'westus2'

resource account 'Microsoft.CognitiveServices/accounts@2025-06-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'S0'
  }
  kind: 'AIServices'
  properties: {
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: false
    allowProjectManagement: true
    customSubDomainName: 'cog-${resourceName}'
    disableLocalAuth: false
    dynamicThrottlingEnabled: false
  }
}

resource project 'Microsoft.CognitiveServices/accounts/projects@2025-06-01' = {
  name: resourceName
  location: location
  parent: account
  properties: {
    description: 'test project'
    displayName: 'project-${resourceName}'
  }
}
