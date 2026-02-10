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
    hostingMode: 'default'
    networkRuleSet: {
      ipRules: []
    }
    partitionCount: 1
    publicNetworkAccess: 'Enabled'
    replicaCount: 1
    encryptionWithCmk: {
      enforcement: 'Disabled'
    }
    authOptions: {
      apiKeyOnly: {}
    }
  }
  tags: {
    environment: 'staging'
  }
}
