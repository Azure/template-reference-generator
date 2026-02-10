param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    capabilities: [
      {
        name: 'EnableGremlin'
      }
    ]
    consistencyPolicy: {
      defaultConsistencyLevel: 'Strong'
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
    }
    disableLocalAuth: false
    networkAclBypassResourceIds: []
    publicNetworkAccess: 'Enabled'
    defaultIdentity: 'FirstPartyIdentity'
    disableKeyBasedMetadataWriteAccess: false
    enableAnalyticalStorage: false
    enableFreeTier: false
    networkAclBypass: 'None'
    virtualNetworkRules: []
    enableMultipleWriteLocations: false
    isVirtualNetworkFilterEnabled: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    databaseAccountOfferType: 'Standard'
    enableAutomaticFailover: false
    ipRules: []
  }
}

resource gremlinDatabase 'Microsoft.DocumentDB/databaseAccounts/gremlinDatabases@2023-04-15' = {
  name: resourceName
  parent: databaseAccount
  properties: {
    options: {}
    resource: {
      id: '${resourceName}'
    }
  }
}

resource graph 'Microsoft.DocumentDB/databaseAccounts/gremlinDatabases/graphs@2023-04-15' = {
  name: resourceName
  parent: gremlinDatabase
  properties: {
    options: {
      throughput: 400
    }
    resource: {
      id: '${resourceName}'
      partitionKey: {
        kind: 'Hash'
        paths: [
          '/test'
        ]
      }
    }
  }
}
