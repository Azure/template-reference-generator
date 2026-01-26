param resourceName string = 'acctest0001'
param location string = 'westus2'

resource account 'Microsoft.CognitiveServices/accounts@2025-06-01' = {
  name: resourceName
  location: location
  kind: 'AIServices'
  properties: {
    allowProjectManagement: true
    customSubDomainName: 'cog-acctest0001'
    disableLocalAuth: false
    dynamicThrottlingEnabled: false
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: false
  }
  sku: {
    name: 'S0'
  }
}

resource project 'Microsoft.CognitiveServices/accounts/projects@2025-06-01' = {
  parent: account
  name: resourceName
  location: location
  properties: {
    description: 'test project'
    displayName: 'project-acctest0001'
  }
}
