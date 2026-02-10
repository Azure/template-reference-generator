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
    defaultIdentity: 'FirstPartyIdentity'
    disableLocalAuth: false
    virtualNetworkRules: []
    databaseAccountOfferType: 'Standard'
    disableKeyBasedMetadataWriteAccess: false
    enableAnalyticalStorage: false
    enableMultipleWriteLocations: false
    ipRules: []
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    networkAclBypass: 'None'
    networkAclBypassResourceIds: []
    consistencyPolicy: {
      maxStalenessPrefix: 100
      defaultConsistencyLevel: 'Strong'
      maxIntervalInSeconds: 5
    }
    publicNetworkAccess: 'Enabled'
    enableAutomaticFailover: false
    enableFreeTier: false
    isVirtualNetworkFilterEnabled: false
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
