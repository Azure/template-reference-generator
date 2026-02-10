param resourceName string = 'acctest0001'
param location string = 'eastus'

var accountName = 'resourcename'
var keyspaceName = 'resourcenameks'
var tableName = 'resourcenametbl'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2024-08-15' = {
  name: accountName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    disableLocalAuth: false
    enableFreeTier: false
    ipRules: []
    consistencyPolicy: {
      maxStalenessPrefix: 100
      defaultConsistencyLevel: 'Strong'
      maxIntervalInSeconds: 5
    }
    defaultIdentity: 'FirstPartyIdentity'
    enableBurstCapacity: false
    enablePartitionMerge: false
    locations: [
      {
        isZoneRedundant: false
        locationName: '${location}'
        failoverPriority: 0
      }
    ]
    networkAclBypassResourceIds: []
    capabilities: [
      {
        name: 'EnableCassandra'
      }
    ]
    databaseAccountOfferType: 'Standard'
    disableKeyBasedMetadataWriteAccess: false
    virtualNetworkRules: []
    enableAnalyticalStorage: true
    enableAutomaticFailover: false
    enableMultipleWriteLocations: false
    isVirtualNetworkFilterEnabled: false
    minimalTlsVersion: 'Tls12'
    networkAclBypass: 'None'
    publicNetworkAccess: 'Enabled'
    backupPolicy: null
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
      schema: {
        partitionKeys: [
          {
            name: 'test1'
          }
        ]
        clusterKeys: []
        columns: [
          {
            name: 'test1'
            type: 'ascii'
          }
          {
            name: 'test2'
            type: 'int'
          }
        ]
      }
      analyticalStorageTtl: 1
      id: '${tableName}'
    }
  }
}
