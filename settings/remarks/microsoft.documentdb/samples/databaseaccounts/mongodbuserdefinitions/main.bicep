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
        locationName: location
      }
    ]
    minimalTlsVersion: 'Tls12'
    networkAclBypass: 'None'
    networkAclBypassResourceIds: []
    publicNetworkAccess: 'Enabled'
    virtualNetworkRules: []
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
