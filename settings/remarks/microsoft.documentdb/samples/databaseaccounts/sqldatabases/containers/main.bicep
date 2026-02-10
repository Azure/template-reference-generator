param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    consistencyPolicy: {
      defaultConsistencyLevel: 'BoundedStaleness'
      maxIntervalInSeconds: 10
      maxStalenessPrefix: 200
    }
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        isZoneRedundant: false
        locationName: 'West Europe'
        failoverPriority: 0
      }
    ]
    capabilities: []
    disableKeyBasedMetadataWriteAccess: false
    disableLocalAuth: false
    enableFreeTier: false
    isVirtualNetworkFilterEnabled: false
    networkAclBypass: 'None'
    enableAutomaticFailover: false
    enableMultipleWriteLocations: false
    ipRules: []
    virtualNetworkRules: []
    defaultIdentity: 'FirstPartyIdentity'
    enableAnalyticalStorage: false
    networkAclBypassResourceIds: []
    publicNetworkAccess: 'Enabled'
  }
}

resource sqlDatabase 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2021-10-15' = {
  name: resourceName
  parent: databaseAccount
  properties: {
    resource: {
      id: '${resourceName}'
    }
    options: {
      throughput: 400
    }
  }
}

resource container 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2023-04-15' = {
  name: resourceName
  parent: sqlDatabase
  properties: {
    options: {}
    resource: {
      id: 'test-containerWest Europe'
      partitionKey: {
        kind: 'Hash'
        paths: [
          '/definition'
        ]
      }
    }
  }
}
