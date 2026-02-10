param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    defaultIdentity: 'FirstPartyIdentity'
    enableAnalyticalStorage: false
    enableFreeTier: false
    enableMultipleWriteLocations: false
    ipRules: []
    locations: [
      {
        locationName: 'West Europe'
        failoverPriority: 0
        isZoneRedundant: false
      }
    ]
    virtualNetworkRules: []
    capabilities: []
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
    }
    disableKeyBasedMetadataWriteAccess: false
    networkAclBypassResourceIds: []
    networkAclBypass: 'None'
    databaseAccountOfferType: 'Standard'
    disableLocalAuth: false
    enableAutomaticFailover: false
    isVirtualNetworkFilterEnabled: false
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
    options: {}
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
      body: 'function trigger(){}'
      id: '${resourceName}'
      triggerOperation: 'All'
      triggerType: 'Pre'
    }
  }
}
