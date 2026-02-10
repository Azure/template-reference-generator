param resourceName string = 'acctest0001'
param location string = 'eastus'

var keyspaceName = 'resourcenameks'
var tableName = 'resourcenametbl'
var accountName = 'resourcename'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2024-08-15' = {
  name: accountName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    capabilities: [
      {
        name: 'EnableCassandra'
      }
    ]
    enableBurstCapacity: false
    enableFreeTier: false
    enablePartitionMerge: false
    minimalTlsVersion: 'Tls12'
    networkAclBypassResourceIds: []
    databaseAccountOfferType: 'Standard'
    disableLocalAuth: false
    enableAnalyticalStorage: true
    enableAutomaticFailover: false
    backupPolicy: null
    disableKeyBasedMetadataWriteAccess: false
    enableMultipleWriteLocations: false
    ipRules: []
    isVirtualNetworkFilterEnabled: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: '${location}'
      }
    ]
    networkAclBypass: 'None'
    publicNetworkAccess: 'Enabled'
    consistencyPolicy: {
      maxStalenessPrefix: 100
      defaultConsistencyLevel: 'Strong'
      maxIntervalInSeconds: 5
    }
    defaultIdentity: 'FirstPartyIdentity'
    virtualNetworkRules: []
  }
}

resource cassandraKeyspace 'Microsoft.DocumentDB/databaseAccounts/cassandraKeyspaces@2021-10-15' = {
  name: keyspaceName
  parent: databaseAccount
  properties: {
    options: {}
    resource: {
      id: '${keyspaceName}'
    }
  }
}

resource table 'Microsoft.DocumentDB/databaseAccounts/cassandraKeyspaces/tables@2021-10-15' = {
  name: tableName
  parent: cassandraKeyspace
  properties: {
    options: {}
    resource: {
      analyticalStorageTtl: 1
      id: '${tableName}'
      schema: {
        clusterKeys: []
        columns: [
          {
            name: 'test1'
            type: 'ascii'
          }
          {
            type: 'int'
            name: 'test2'
          }
        ]
        partitionKeys: [
          {
            name: 'test1'
          }
        ]
      }
    }
  }
}
