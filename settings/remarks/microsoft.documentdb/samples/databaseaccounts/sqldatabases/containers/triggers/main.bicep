param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
    }
    isVirtualNetworkFilterEnabled: false
    ipRules: []
    publicNetworkAccess: 'Enabled'
    disableKeyBasedMetadataWriteAccess: false
    enableAutomaticFailover: false
    enableFreeTier: false
    locations: [
      {
        isZoneRedundant: false
        locationName: 'West Europe'
        failoverPriority: 0
      }
    ]
    networkAclBypass: 'None'
    networkAclBypassResourceIds: []
    virtualNetworkRules: []
    capabilities: []
    databaseAccountOfferType: 'Standard'
    defaultIdentity: 'FirstPartyIdentity'
    disableLocalAuth: false
    enableAnalyticalStorage: false
    enableMultipleWriteLocations: false
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
      body: 'function trigger(){}'
      id: '${resourceName}'
      triggerOperation: 'All'
      triggerType: 'Pre'
    }
  }
}
