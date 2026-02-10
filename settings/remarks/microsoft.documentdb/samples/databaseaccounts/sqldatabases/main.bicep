param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    isVirtualNetworkFilterEnabled: false
    networkAclBypass: 'None'
    disableKeyBasedMetadataWriteAccess: false
    disableLocalAuth: false
    enableAnalyticalStorage: false
    ipRules: []
    networkAclBypassResourceIds: []
    virtualNetworkRules: []
    capabilities: []
    consistencyPolicy: {
      maxIntervalInSeconds: 10
      maxStalenessPrefix: 200
      defaultConsistencyLevel: 'BoundedStaleness'
    }
    defaultIdentity: 'FirstPartyIdentity'
    enableAutomaticFailover: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    databaseAccountOfferType: 'Standard'
    publicNetworkAccess: 'Enabled'
    enableFreeTier: false
    enableMultipleWriteLocations: false
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
