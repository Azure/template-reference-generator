param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    disableKeyBasedMetadataWriteAccess: false
    enableAnalyticalStorage: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    networkAclBypass: 'None'
    publicNetworkAccess: 'Enabled'
    isVirtualNetworkFilterEnabled: false
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
    }
    databaseAccountOfferType: 'Standard'
    defaultIdentity: 'FirstPartyIdentity'
    disableLocalAuth: false
    enableFreeTier: false
    ipRules: []
    capabilities: []
    enableAutomaticFailover: false
    enableMultipleWriteLocations: false
    networkAclBypassResourceIds: []
    virtualNetworkRules: []
  }
}

resource sqlDatabase 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2021-10-15' = {
  name: resourceName
  parent: databaseAccount
  properties: {
    options: {}
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
      id: '${resourceName}'
      partitionKey: {
        kind: 'Hash'
        paths: [
          '/definition/id'
        ]
      }
    }
  }
}

resource trigger 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/triggers@2021-10-15' = {
  name: resourceName
  parent: container
  properties: {
    options: {}
    resource: {
      triggerOperation: 'All'
      triggerType: 'Pre'
      body: 'function trigger(){}'
      id: '${resourceName}'
    }
  }
}
