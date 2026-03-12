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
    backupPolicy: null
    enableAutomaticFailover: false
    enableBurstCapacity: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: '${location}'
      }
    ]
    minimalTlsVersion: 'Tls12'
    virtualNetworkRules: []
    capabilities: [
      {
        name: 'EnableCassandra'
      }
    ]
    consistencyPolicy: {
      defaultConsistencyLevel: 'Strong'
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
    }
    databaseAccountOfferType: 'Standard'
    disableKeyBasedMetadataWriteAccess: false
    disableLocalAuth: false
    enableFreeTier: false
    enablePartitionMerge: false
    networkAclBypassResourceIds: []
    enableAnalyticalStorage: true
    isVirtualNetworkFilterEnabled: false
    networkAclBypass: 'None'
    publicNetworkAccess: 'Enabled'
    defaultIdentity: 'FirstPartyIdentity'
    enableMultipleWriteLocations: false
    ipRules: []
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
            name: 'test2'
            type: 'int'
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
