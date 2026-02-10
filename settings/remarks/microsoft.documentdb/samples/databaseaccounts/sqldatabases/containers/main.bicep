param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    disableKeyBasedMetadataWriteAccess: false
    enableAutomaticFailover: false
    enableFreeTier: false
    virtualNetworkRules: []
    consistencyPolicy: {
      defaultConsistencyLevel: 'BoundedStaleness'
      maxIntervalInSeconds: 10
      maxStalenessPrefix: 200
    }
    ipRules: []
    networkAclBypass: 'None'
    publicNetworkAccess: 'Enabled'
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    capabilities: []
    defaultIdentity: 'FirstPartyIdentity'
    disableLocalAuth: false
    enableAnalyticalStorage: false
    isVirtualNetworkFilterEnabled: false
    networkAclBypassResourceIds: []
    databaseAccountOfferType: 'Standard'
    enableMultipleWriteLocations: false
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
    resource: {
      id: 'test-containerWest Europe'
      partitionKey: {
        kind: 'Hash'
        paths: [
          '/definition'
        ]
      }
    }
    options: {}
  }
}
