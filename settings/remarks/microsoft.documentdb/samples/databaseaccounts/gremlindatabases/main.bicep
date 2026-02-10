param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    databaseAccountOfferType: 'Standard'
    disableKeyBasedMetadataWriteAccess: false
    disableLocalAuth: false
    isVirtualNetworkFilterEnabled: false
    networkAclBypass: 'None'
    networkAclBypassResourceIds: []
    defaultIdentity: 'FirstPartyIdentity'
    enableAutomaticFailover: false
    enableMultipleWriteLocations: false
    ipRules: []
    virtualNetworkRules: []
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    capabilities: [
      {
        name: 'EnableGremlin'
      }
    ]
    enableAnalyticalStorage: false
    enableFreeTier: false
    publicNetworkAccess: 'Enabled'
    consistencyPolicy: {
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
      defaultConsistencyLevel: 'Strong'
    }
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
