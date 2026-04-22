param location string = 'eastus'
param resourceName string = 'acctest0001'

var dbName = 'resourcenamedb'
var roleName = 'resourcenamerole'
var accountName = 'resourcename'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2024-08-15' = {
  name: accountName
  location: location
  kind: 'MongoDB'
  properties: {
    databaseAccountOfferType: 'Standard'
    disableLocalAuth: false
    enableAnalyticalStorage: false
    enableAutomaticFailover: false
    enableBurstCapacity: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: '${location}'
      }
    ]
    virtualNetworkRules: []
    backupPolicy: null
    disableKeyBasedMetadataWriteAccess: false
    ipRules: []
    networkAclBypassResourceIds: []
    enablePartitionMerge: false
    consistencyPolicy: {
      defaultConsistencyLevel: 'Strong'
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
    }
    enableFreeTier: false
    isVirtualNetworkFilterEnabled: false
    minimalTlsVersion: 'Tls12'
    defaultIdentity: 'FirstPartyIdentity'
    enableMultipleWriteLocations: false
    networkAclBypass: 'None'
    publicNetworkAccess: 'Enabled'
    capabilities: [
      {
        name: 'EnableMongoRoleBasedAccessControl'
      }
      {
        name: 'EnableMongo'
      }
    ]
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
