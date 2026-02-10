param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator login password for the SQL server')
param administratorLoginPassword string

resource server 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: resourceName
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

resource database 'Microsoft.Sql/servers/databases@2021-02-01-preview' = {
  name: resourceName
  location: location
  parent: server
  properties: {
    autoPauseDelay: 0
    createMode: 'Default'
    isLedgerOn: false
    maintenanceConfigurationId: resourceId('Microsoft.Maintenance/publicMaintenanceConfigurations', 'SQL_Default')
    readScale: 'Disabled'
    requestedBackupStorageRedundancy: 'Geo'
    elasticPoolId: ''
    highAvailabilityReplicaCount: 0
    licenseType: 'LicenseIncluded'
    minCapacity: 0
    zoneRedundant: false
  }
}

resource transparentDataEncryption 'Microsoft.Sql/servers/databases/transparentDataEncryption@2014-04-01' = {
  name: 'current'
  parent: database
  properties: {
    status: 'Enabled'
  }
}
