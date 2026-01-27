param resourceName string = 'acctest0001'
param location string = 'eastus'

var keyspaceName = '${toLower(resourceName)}ks'
var tableName = '${toLower(resourceName)}tbl'
var accountName = toLower(replace(resourceName, '-', ''))

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2024-08-15' = {
  name: accountName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    backupPolicy: null
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
    defaultIdentity: 'FirstPartyIdentity'
    disableKeyBasedMetadataWriteAccess: false
    disableLocalAuth: false
    enableAnalyticalStorage: true
    enableAutomaticFailover: false
    enableBurstCapacity: false
    enableFreeTier: false
    enableMultipleWriteLocations: false
    enablePartitionMerge: false
    ipRules: []
    isVirtualNetworkFilterEnabled: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'eastus'
      }
    ]
    minimalTlsVersion: 'Tls12'
    networkAclBypass: 'None'
    networkAclBypassResourceIds: []
    publicNetworkAccess: 'Enabled'
    virtualNetworkRules: []
  }
}

resource cassandraKeyspace 'Microsoft.DocumentDB/databaseAccounts/cassandraKeyspaces@2021-10-15' = {
  parent: databaseAccount
  name: keyspaceName
  properties: {
    options: {}
    resource: {
      id: keyspaceName
    }
  }
}

resource table 'Microsoft.DocumentDB/databaseAccounts/cassandraKeyspaces/tables@2021-10-15' = {
  parent: cassandraKeyspace
  name: tableName
  properties: {
    options: {}
    resource: {
      analyticalStorageTtl: 1
      id: tableName
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
