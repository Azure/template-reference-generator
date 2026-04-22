param resourceName string = 'acctest0001'
param location string = 'westus'

resource account 'Microsoft.CognitiveServices/accounts@2024-10-01' = {
  name: '${resourceName}-ca'
  location: location
  sku: {
    name: 'S0'
  }
  kind: 'OpenAI'
  properties: {
    customSubDomainName: ''
    disableLocalAuth: false
    dynamicThrottlingEnabled: false
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: false
    allowedFqdnList: []
    apiProperties: {}
  }
}

resource raiBlocklist 'Microsoft.CognitiveServices/accounts/raiBlocklists@2024-10-01' = {
  name: '${resourceName}-crb'
  parent: account
  properties: {
    description: 'Acceptance test data new azurerm resource'
  }
}
