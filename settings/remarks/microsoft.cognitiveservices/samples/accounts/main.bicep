param resourceName string = 'acctest0001'
param location string = 'westus2'

resource account 'Microsoft.CognitiveServices/accounts@2022-10-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'S0'
    tier: 'Standard'
  }
  kind: 'SpeechServices'
  properties: {
    allowedFqdnList: []
    apiProperties: {}
    customSubDomainName: 'acctest-cogacc-230630032807723157'
    disableLocalAuth: false
    dynamicThrottlingEnabled: false
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: false
  }
}

resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: resourceName
  location: location
}
