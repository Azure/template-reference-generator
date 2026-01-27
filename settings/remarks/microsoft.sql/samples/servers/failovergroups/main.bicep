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
    administratorLogin: 'mradministrator'
    administratorLoginPassword: null
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    version: '12.0'
  }
}

resource server1 'Microsoft.Sql/servers@2023-08-01-preview' = {
  name: '${resourceName}-secondary'
  properties: {
    administratorLogin: 'mradministrator'
    administratorLoginPassword: null
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    version: '12.0'
  }
}

resource database 'Microsoft.Sql/servers/databases@2023-08-01-preview' = {
  parent: server
  name: '${resourceName}-db'
  location: location
  properties: {
    autoPauseDelay: 0
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    createMode: 'Default'
    elasticPoolId: ''
    encryptionProtectorAutoRotation: false
    highAvailabilityReplicaCount: 0
    isLedgerOn: false
    licenseType: ''
    maxSizeBytes: 214748364800
    minCapacity: 0
    readScale: 'Disabled'
    requestedBackupStorageRedundancy: 'Geo'
    sampleName: ''
    secondaryType: ''
    zoneRedundant: false
  }
  sku: {
    name: 'S1'
  }
}

resource failoverGroup 'Microsoft.Sql/servers/failoverGroups@2023-08-01-preview' = {
  parent: server
  name: '${resourceName}-fg'
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
