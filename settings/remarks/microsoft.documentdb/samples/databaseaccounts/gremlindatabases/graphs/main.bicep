param location string = 'westeurope'
param resourceName string = 'acctest0001'

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
    disableLocalAuth: false
    enableAnalyticalStorage: false
    enableFreeTier: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    virtualNetworkRules: []
    consistencyPolicy: {
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
      defaultConsistencyLevel: 'Strong'
    }
    databaseAccountOfferType: 'Standard'
    disableKeyBasedMetadataWriteAccess: false
    enableAutomaticFailover: false
    enableMultipleWriteLocations: false
    ipRules: []
    networkAclBypassResourceIds: []
    publicNetworkAccess: 'Enabled'
    defaultIdentity: 'FirstPartyIdentity'
    isVirtualNetworkFilterEnabled: false
    networkAclBypass: 'None'
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
      partitionKey: {
        kind: 'Hash'
        paths: [
          '/test'
        ]
      }
      id: '${resourceName}'
    }
  }
}
