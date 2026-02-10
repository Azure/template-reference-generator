param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    defaultIdentity: 'FirstPartyIdentity'
    enableMultipleWriteLocations: false
    networkAclBypass: 'None'
    consistencyPolicy: {
      maxStalenessPrefix: 200
      defaultConsistencyLevel: 'BoundedStaleness'
      maxIntervalInSeconds: 10
    }
    disableKeyBasedMetadataWriteAccess: false
    ipRules: []
    isVirtualNetworkFilterEnabled: false
    publicNetworkAccess: 'Enabled'
    virtualNetworkRules: []
    disableLocalAuth: false
    enableAnalyticalStorage: false
    networkAclBypassResourceIds: []
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    capabilities: []
    databaseAccountOfferType: 'Standard'
    enableAutomaticFailover: false
    enableFreeTier: false
  }
}

resource sqlDatabase 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2021-10-15' = {
  name: resourceName
  parent: databaseAccount
  properties: {
    options: {
      throughput: 400
    }
    resource: {
      id: '${resourceName}'
    }
  }
}
