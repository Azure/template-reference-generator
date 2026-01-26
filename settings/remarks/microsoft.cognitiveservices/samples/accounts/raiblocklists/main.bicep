param resourceName string = 'acctest0001'
param location string = 'westus'

resource account 'Microsoft.CognitiveServices/accounts@2024-10-01' = {
  name: '${resourceName}-ca'
  location: location
  kind: 'OpenAI'
  properties: {
    allowedFqdnList: []
    apiProperties: {}
    customSubDomainName: ''
    disableLocalAuth: false
    dynamicThrottlingEnabled: false
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: false
  }
  sku: {
    name: 'S0'
  }
}

resource raiBlocklist 'Microsoft.CognitiveServices/accounts/raiBlocklists@2024-10-01' = {
  parent: account
  name: '${resourceName}-crb'
  properties: {
    description: 'Acceptance test data new azurerm resource'
  }
}
