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
    enableAutomaticFailover: false
    minimalTlsVersion: 'Tls12'
    networkAclBypass: 'None'
    publicNetworkAccess: 'Enabled'
    databaseAccountOfferType: 'Standard'
    enableMultipleWriteLocations: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: '${location}'
      }
    ]
    enableAnalyticalStorage: false
    enableBurstCapacity: false
    enablePartitionMerge: false
    ipRules: []
    isVirtualNetworkFilterEnabled: false
    networkAclBypassResourceIds: []
    virtualNetworkRules: []
    backupPolicy: null
    enableFreeTier: false
    capabilities: [
      {
        name: 'EnableMongoRoleBasedAccessControl'
      }
      {
        name: 'EnableMongo'
      }
    ]
    consistencyPolicy: {
      maxStalenessPrefix: 100
      defaultConsistencyLevel: 'Strong'
      maxIntervalInSeconds: 5
    }
    disableKeyBasedMetadataWriteAccess: false
    disableLocalAuth: false
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
    databaseName: mongodbDatabas.name
    mechanisms: 'SCRAM-SHA-256'
    password: mongodbUserPassword
    userName: 'myUserName'
  }
}
