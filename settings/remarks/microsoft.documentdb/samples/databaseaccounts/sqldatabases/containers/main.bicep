param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    disableKeyBasedMetadataWriteAccess: false
    enableAnalyticalStorage: false
    networkAclBypass: 'None'
    enableAutomaticFailover: false
    virtualNetworkRules: []
    consistencyPolicy: {
      maxIntervalInSeconds: 10
      maxStalenessPrefix: 200
      defaultConsistencyLevel: 'BoundedStaleness'
    }
    defaultIdentity: 'FirstPartyIdentity'
    disableLocalAuth: false
    ipRules: []
    isVirtualNetworkFilterEnabled: false
    publicNetworkAccess: 'Enabled'
    capabilities: []
    databaseAccountOfferType: 'Standard'
    enableFreeTier: false
    enableMultipleWriteLocations: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    networkAclBypassResourceIds: []
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

resource container 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2023-04-15' = {
  name: resourceName
  parent: sqlDatabase
  properties: {
    options: {}
    resource: {
      id: 'test-containerWest Europe'
      partitionKey: {
        paths: [
          '/definition'
        ]
        kind: 'Hash'
      }
    }
  }
}
