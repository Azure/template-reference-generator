param resourceName string = 'acctest0001'
param location string = 'westus'
@secure()
@description('The password for the MongoDB user')
param mongodbUserPassword string

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2024-08-15' = {
  name: '${resourceName}-acct'
  location: location
  kind: 'MongoDB'
  properties: {
    consistencyPolicy: {
      maxStalenessPrefix: 100
      defaultConsistencyLevel: 'Strong'
      maxIntervalInSeconds: 5
    }
    enablePartitionMerge: false
    ipRules: []
    isVirtualNetworkFilterEnabled: false
    publicNetworkAccess: 'Enabled'
    disableLocalAuth: false
    enableAutomaticFailover: false
    databaseAccountOfferType: 'Standard'
    enableAnalyticalStorage: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: '${location}'
      }
    ]
    networkAclBypass: 'None'
    networkAclBypassResourceIds: []
    virtualNetworkRules: []
    capabilities: [
      {
        name: 'EnableMongoRoleBasedAccessControl'
      }
      {
        name: 'EnableMongo'
      }
    ]
    disableKeyBasedMetadataWriteAccess: false
    enableBurstCapacity: false
    enableFreeTier: false
    enableMultipleWriteLocations: false
    minimalTlsVersion: 'Tls12'
    backupPolicy: null
  }
}

resource mongodbDatabas 'Microsoft.DocumentDB/databaseAccounts/mongodbDatabases@2021-10-15' = {
  name: '${resourceName}-mongodb'
  parent: databaseAccount
  properties: {
    options: {}
    resource: {
      id: '${resourceName}-mongodb'
    }
  }
}

resource mongodbUserDefinition 'Microsoft.DocumentDB/databaseAccounts/mongodbUserDefinitions@2022-11-15' = {
  name: '${mongodbDatabas.name}.myUserName'
  parent: databaseAccount
  properties: {
    userName: 'myUserName'
    databaseName: mongodbDatabas.name
    mechanisms: 'SCRAM-SHA-256'
    password: mongodbUserPassword
  }
}
