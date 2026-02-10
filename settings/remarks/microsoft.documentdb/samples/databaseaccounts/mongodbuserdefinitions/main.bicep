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
    networkAclBypass: 'None'
    backupPolicy: null
    disableLocalAuth: false
    enableAnalyticalStorage: false
    enableAutomaticFailover: false
    enableFreeTier: false
    isVirtualNetworkFilterEnabled: false
    capabilities: [
      {
        name: 'EnableMongoRoleBasedAccessControl'
      }
      {
        name: 'EnableMongo'
      }
    ]
    enableBurstCapacity: false
    enableMultipleWriteLocations: false
    enablePartitionMerge: false
    ipRules: []
    virtualNetworkRules: []
    databaseAccountOfferType: 'Standard'
    disableKeyBasedMetadataWriteAccess: false
    networkAclBypassResourceIds: []
    publicNetworkAccess: 'Enabled'
    consistencyPolicy: {
      defaultConsistencyLevel: 'Strong'
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
    }
    locations: [
      {
        locationName: '${location}'
        failoverPriority: 0
        isZoneRedundant: false
      }
    ]
    minimalTlsVersion: 'Tls12'
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
    password: mongodbUserPassword
    userName: 'myUserName'
    databaseName: mongodbDatabas.name
    mechanisms: 'SCRAM-SHA-256'
  }
}
