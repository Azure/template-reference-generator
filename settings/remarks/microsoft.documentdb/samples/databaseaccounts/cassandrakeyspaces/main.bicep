param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    ipRules: []
    isVirtualNetworkFilterEnabled: false
    capabilities: [
      {
        name: 'EnableCassandra'
      }
    ]
    enableAnalyticalStorage: false
    networkAclBypassResourceIds: []
    publicNetworkAccess: 'Enabled'
    databaseAccountOfferType: 'Standard'
    disableKeyBasedMetadataWriteAccess: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    networkAclBypass: 'None'
    enableAutomaticFailover: false
    enableFreeTier: false
    virtualNetworkRules: []
    consistencyPolicy: {
      maxStalenessPrefix: 100
      defaultConsistencyLevel: 'Strong'
      maxIntervalInSeconds: 5
    }
    defaultIdentity: 'FirstPartyIdentity'
    disableLocalAuth: false
    enableMultipleWriteLocations: false
  }
}

resource cassandraKeyspace 'Microsoft.DocumentDB/databaseAccounts/cassandraKeyspaces@2021-10-15' = {
  name: resourceName
  parent: databaseAccount
  properties: {
    options: {}
    resource: {
      id: '${resourceName}'
    }
  }
}
