param resourceName string = 'acctest0001'
param location string = 'westus2'

resource account 'Microsoft.CognitiveServices/accounts@2022-10-01' = {
  name: resourceName
  location: location
  sku: {
    tier: 'Standard'
    name: 'S0'
  }
  kind: 'SpeechServices'
  properties: {
    dynamicThrottlingEnabled: false
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: false
    allowedFqdnList: []
    apiProperties: {}
    customSubDomainName: 'acctest-cogacc-230630032807723157'
    disableLocalAuth: false
  }
}

resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: resourceName
  location: location
}
