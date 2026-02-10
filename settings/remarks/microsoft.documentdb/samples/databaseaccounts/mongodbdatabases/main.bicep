param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'MongoDB'
  properties: {
    capabilities: [
      {
        name: 'EnableMongo'
      }
    ]
    defaultIdentity: 'FirstPartyIdentity'
    disableKeyBasedMetadataWriteAccess: false
    enableAutomaticFailover: false
    enableMultipleWriteLocations: false
    ipRules: []
    locations: [
      {
        locationName: 'West Europe'
        failoverPriority: 0
        isZoneRedundant: false
      }
    ]
    networkAclBypass: 'None'
    consistencyPolicy: {
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
      defaultConsistencyLevel: 'Strong'
    }
    databaseAccountOfferType: 'Standard'
    enableFreeTier: false
    isVirtualNetworkFilterEnabled: false
    publicNetworkAccess: 'Enabled'
    virtualNetworkRules: []
    disableLocalAuth: false
    networkAclBypassResourceIds: []
    enableAnalyticalStorage: false
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
