@secure()
@description('The administrator login password for the SQL server')
param administratorLoginPassword string
param resourceName string = 'acctest0001'
param location string = 'westus'
param secondaryLocation string = 'eastus'

resource server 'Microsoft.Sql/servers@2023-08-01-preview' = {
  name: '${resourceName}-primary'
  location: location
  properties: {
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    version: '12.0'
    administratorLogin: 'mradministrator'
    administratorLoginPassword: '${administratorLoginPassword}'
  }
}

resource server1 'Microsoft.Sql/servers@2023-08-01-preview' = {
  name: '${resourceName}-secondary'
  location: secondaryLocation
  properties: {
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    version: '12.0'
    administratorLogin: 'mradministrator'
    administratorLoginPassword: '${administratorLoginPassword}'
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
    createMode: 'Default'
    minCapacity: 0
    readScale: 'Disabled'
    zoneRedundant: false
    autoPauseDelay: 0
    elasticPoolId: ''
    encryptionProtectorAutoRotation: false
    isLedgerOn: false
    secondaryType: ''
    highAvailabilityReplicaCount: 0
    requestedBackupStorageRedundancy: 'Geo'
    sampleName: ''
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    licenseType: ''
    maxSizeBytes: 214748364800
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
