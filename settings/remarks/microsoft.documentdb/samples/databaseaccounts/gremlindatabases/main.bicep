param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    defaultIdentity: 'FirstPartyIdentity'
    isVirtualNetworkFilterEnabled: false
    consistencyPolicy: {
      maxStalenessPrefix: 100
      defaultConsistencyLevel: 'Strong'
      maxIntervalInSeconds: 5
    }
    disableLocalAuth: false
    enableAutomaticFailover: false
    ipRules: []
    publicNetworkAccess: 'Enabled'
    databaseAccountOfferType: 'Standard'
    disableKeyBasedMetadataWriteAccess: false
    enableAnalyticalStorage: false
    enableFreeTier: false
    enableMultipleWriteLocations: false
    networkAclBypass: 'None'
    capabilities: [
      {
        name: 'EnableGremlin'
      }
    ]
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    networkAclBypassResourceIds: []
    virtualNetworkRules: []
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
