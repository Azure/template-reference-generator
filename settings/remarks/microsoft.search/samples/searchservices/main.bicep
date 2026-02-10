param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource searchService 'Microsoft.Search/searchServices@2022-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'standard'
  }
  properties: {
    disableLocalAuth: false
    encryptionWithCmk: {
      enforcement: 'Disabled'
    }
    hostingMode: 'default'
    networkRuleSet: {
      ipRules: []
    }
    publicNetworkAccess: 'Enabled'
    replicaCount: 1
    authOptions: {
      apiKeyOnly: {}
    }
    partitionCount: 1
  }
  tags: {
    environment: 'staging'
  }
}
