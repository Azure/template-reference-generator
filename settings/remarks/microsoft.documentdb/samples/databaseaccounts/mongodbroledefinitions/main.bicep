param resourceName string = 'acctest0001'
param location string = 'eastus'

var accountName = toLower(replace(resourceName, '-', ''))
var dbName = '${toLower(resourceName)}db'
var roleName = '${toLower(resourceName)}role'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2024-08-15' = {
  name: accountName
  location: location
  kind: 'MongoDB'
  properties: {
    backupPolicy: null
    capabilities: [
      {
        name: 'EnableMongoRoleBasedAccessControl'
      }
      {
        name: 'EnableMongo'
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
    enableAnalyticalStorage: false
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

resource mongodbDatabase 'Microsoft.DocumentDB/databaseAccounts/mongodbDatabases@2021-10-15' = {
  parent: databaseAccount
  name: dbName
  properties: {
    options: {}
    resource: {
      id: dbName
    }
  }
}

resource mongodbRoleDefinition 'Microsoft.DocumentDB/databaseAccounts/mongodbRoleDefinitions@2022-11-15' = {
  parent: databaseAccount
  name: '${dbName}.${roleName}'
  properties: {
    databaseName: dbName
    roleName: roleName
    type: 1
  }
  dependsOn: [
    mongodbDatabase
  ]
}
