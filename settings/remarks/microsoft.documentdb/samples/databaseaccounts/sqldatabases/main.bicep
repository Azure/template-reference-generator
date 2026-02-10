param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    disableKeyBasedMetadataWriteAccess: false
    enableAutomaticFailover: false
    publicNetworkAccess: 'Enabled'
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
    capabilities: []
    disableLocalAuth: false
    isVirtualNetworkFilterEnabled: false
    enableMultipleWriteLocations: false
    networkAclBypassResourceIds: []
    virtualNetworkRules: []
    networkAclBypass: 'None'
    consistencyPolicy: {
      defaultConsistencyLevel: 'BoundedStaleness'
      maxIntervalInSeconds: 10
      maxStalenessPrefix: 200
    }
    databaseAccountOfferType: 'Standard'
    defaultIdentity: 'FirstPartyIdentity'
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
