param resourceName string = 'acctest0001'
param location string = 'eastus'

var accountName = 'resourcename'
var dbName = 'resourcenamedb'
var roleName = 'resourcenamerole'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2024-08-15' = {
  name: accountName
  location: location
  kind: 'MongoDB'
  properties: {
    consistencyPolicy: {
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
      defaultConsistencyLevel: 'Strong'
    }
    databaseAccountOfferType: 'Standard'
    defaultIdentity: 'FirstPartyIdentity'
    disableKeyBasedMetadataWriteAccess: false
    locations: [
      {
        isZoneRedundant: false
        locationName: '${location}'
        failoverPriority: 0
      }
    ]
    networkAclBypass: 'None'
    networkAclBypassResourceIds: []
    enableBurstCapacity: false
    enablePartitionMerge: false
    ipRules: []
    backupPolicy: null
    disableLocalAuth: false
    enableAnalyticalStorage: false
    enableAutomaticFailover: false
    isVirtualNetworkFilterEnabled: false
    publicNetworkAccess: 'Enabled'
    capabilities: [
      {
        name: 'EnableMongoRoleBasedAccessControl'
      }
      {
        name: 'EnableMongo'
      }
    ]
    enableFreeTier: false
    enableMultipleWriteLocations: false
    minimalTlsVersion: 'Tls12'
    virtualNetworkRules: []
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
