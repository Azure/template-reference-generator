param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    networkAclBypassResourceIds: []
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
    ipRules: []
    virtualNetworkRules: []
    networkAclBypass: 'None'
    disableLocalAuth: false
    enableAnalyticalStorage: false
    enableAutomaticFailover: false
    databaseAccountOfferType: 'Standard'
    isVirtualNetworkFilterEnabled: false
    publicNetworkAccess: 'Enabled'
    defaultIdentity: 'FirstPartyIdentity'
    disableKeyBasedMetadataWriteAccess: false
    enableFreeTier: false
    enableMultipleWriteLocations: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
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
