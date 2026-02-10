param resourceName string = 'acctest0001'
param location string = 'westus'
param secondaryLocation string = 'eastus'
@secure()
@description('The administrator login password for the SQL server')
param administratorLoginPassword string

resource server 'Microsoft.Sql/servers@2023-08-01-preview' = {
  name: '${resourceName}-primary'
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    version: '12.0'
    administratorLogin: 'mradministrator'
    administratorLoginPassword: '${administratorLoginPassword}'
    minimalTlsVersion: '1.2'
  }
}

resource server1 'Microsoft.Sql/servers@2023-08-01-preview' = {
  name: '${resourceName}-secondary'
  location: secondaryLocation
  properties: {
    restrictOutboundNetworkAccess: 'Disabled'
    version: '12.0'
    administratorLogin: 'mradministrator'
    administratorLoginPassword: '${administratorLoginPassword}'
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
  }
}

resource database 'Microsoft.Sql/servers/databases@2023-08-01-preview' = {
  name: '${resourceName}-db'
  location: location
  parent: server
  sku: {
    name: 'S1'
  }
  properties: {
    elasticPoolId: ''
    highAvailabilityReplicaCount: 0
    requestedBackupStorageRedundancy: 'Geo'
    licenseType: ''
    readScale: 'Disabled'
    secondaryType: ''
    autoPauseDelay: 0
    encryptionProtectorAutoRotation: false
    maxSizeBytes: 214748364800
    minCapacity: 0
    sampleName: ''
    zoneRedundant: false
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    createMode: 'Default'
    isLedgerOn: false
  }
}

resource failoverGroup 'Microsoft.Sql/servers/failoverGroups@2023-08-01-preview' = {
  name: '${resourceName}-fg'
  parent: server
  properties: {
    databases: [
      database.id
    ]
    partnerServers: [
      {
        id: server1.id
      }
    ]
    readOnlyEndpoint: {
      failoverPolicy: 'Disabled'
    }
    readWriteEndpoint: {
      failoverPolicy: 'Automatic'
      failoverWithDataLossGracePeriodMinutes: 60
    }
  }
}
