param resourceName string = 'acctest0003'
param location string = 'eastus'

resource account 'Microsoft.CognitiveServices/accounts@2022-10-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'S0'
  }
  kind: 'OpenAI'
  properties: {
    dynamicThrottlingEnabled: false
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: false
    disableLocalAuth: false
  }
  identity: {
    type: 'None'
    userAssignedIdentities: null
  }
}

resource deployment 'Microsoft.CognitiveServices/accounts/deployments@2023-05-01' = {
  name: 'testdep'
  parent: account
  properties: {
    model: {
      name: 'text-embedding-ada-002'
      format: 'OpenAI'
    }
  }
}
