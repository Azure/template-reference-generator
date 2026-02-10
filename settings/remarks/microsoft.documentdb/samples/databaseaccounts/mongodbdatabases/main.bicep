param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'MongoDB'
  properties: {
    enableAutomaticFailover: false
    enableMultipleWriteLocations: false
    networkAclBypass: 'None'
    capabilities: [
      {
        name: 'EnableMongo'
      }
    ]
    databaseAccountOfferType: 'Standard'
    defaultIdentity: 'FirstPartyIdentity'
    enableAnalyticalStorage: false
    enableFreeTier: false
    ipRules: []
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    publicNetworkAccess: 'Enabled'
    isVirtualNetworkFilterEnabled: false
    virtualNetworkRules: []
    disableLocalAuth: false
    networkAclBypassResourceIds: []
    consistencyPolicy: {
      defaultConsistencyLevel: 'Strong'
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
    }
    disableKeyBasedMetadataWriteAccess: false
  }
}

resource mongodbDatabase 'Microsoft.DocumentDB/databaseAccounts/mongodbDatabases@2021-10-15' = {
  name: resourceName
  parent: databaseAccount
  properties: {
    options: {}
    resource: {
      id: '${resourceName}'
    }
  }
}
