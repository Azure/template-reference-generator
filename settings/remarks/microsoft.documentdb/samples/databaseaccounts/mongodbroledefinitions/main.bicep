param resourceName string = 'acctest0001'
param location string = 'eastus'

var dbName = 'resourcenamedb'
var roleName = 'resourcenamerole'
var accountName = 'resourcename'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2024-08-15' = {
  name: accountName
  location: location
  kind: 'MongoDB'
  properties: {
    minimalTlsVersion: 'Tls12'
    virtualNetworkRules: []
    backupPolicy: null
    disableKeyBasedMetadataWriteAccess: false
    enableAutomaticFailover: false
    isVirtualNetworkFilterEnabled: false
    networkAclBypassResourceIds: []
    consistencyPolicy: {
      maxStalenessPrefix: 100
      defaultConsistencyLevel: 'Strong'
      maxIntervalInSeconds: 5
    }
    disableLocalAuth: false
    enableAnalyticalStorage: false
    enableFreeTier: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: '${location}'
      }
    ]
    publicNetworkAccess: 'Enabled'
    defaultIdentity: 'FirstPartyIdentity'
    enableBurstCapacity: false
    enablePartitionMerge: false
    networkAclBypass: 'None'
    capabilities: [
      {
        name: 'EnableMongoRoleBasedAccessControl'
      }
      {
        name: 'EnableMongo'
      }
    ]
    databaseAccountOfferType: 'Standard'
    enableMultipleWriteLocations: false
    ipRules: []
  }
}

resource mongodbDatabase 'Microsoft.DocumentDB/databaseAccounts/mongodbDatabases@2021-10-15' = {
  name: dbName
  parent: databaseAccount
  properties: {
    options: {}
    resource: {
      id: '${dbName}'
    }
  }
}

resource mongodbRoleDefinition 'Microsoft.DocumentDB/databaseAccounts/mongodbRoleDefinitions@2022-11-15' = {
  name: '${dbName}.${roleName}'
  parent: databaseAccount
  dependsOn: [
    mongodbDatabase
  ]
  properties: {
    databaseName: '${dbName}'
    roleName: '${roleName}'
    type: 1
  }
}
