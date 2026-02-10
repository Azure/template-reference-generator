param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'MongoDB'
  properties: {
    publicNetworkAccess: 'Enabled'
    virtualNetworkRules: []
    disableKeyBasedMetadataWriteAccess: false
    disableLocalAuth: false
    enableAutomaticFailover: false
    databaseAccountOfferType: 'Standard'
    defaultIdentity: 'FirstPartyIdentity'
    enableAnalyticalStorage: false
    enableFreeTier: false
    enableMultipleWriteLocations: false
    ipRules: []
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    networkAclBypassResourceIds: []
    capabilities: [
      {
        name: 'EnableMongo'
      }
    ]
    isVirtualNetworkFilterEnabled: false
    networkAclBypass: 'None'
    consistencyPolicy: {
      defaultConsistencyLevel: 'Strong'
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
    }
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
