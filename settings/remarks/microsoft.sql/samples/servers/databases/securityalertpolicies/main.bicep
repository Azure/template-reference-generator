param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator login password for the SQL server')
param administratorLoginPassword string

resource server 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: resourceName
  location: location
  properties: {
    administratorLogin: 'mradministrator'
    administratorLoginPassword: '${administratorLoginPassword}'
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    version: '12.0'
  }
}

resource database 'Microsoft.Sql/servers/databases@2021-02-01-preview' = {
  name: resourceName
  location: location
  parent: server
  properties: {
    createMode: 'Default'
    elasticPoolId: ''
    highAvailabilityReplicaCount: 0
    isLedgerOn: false
    requestedBackupStorageRedundancy: 'Geo'
    autoPauseDelay: 0
    licenseType: 'LicenseIncluded'
    maintenanceConfigurationId: resourceId('Microsoft.Maintenance/publicMaintenanceConfigurations', 'SQL_Default')
    minCapacity: 0
    readScale: 'Disabled'
    zoneRedundant: false
  }
}

resource securityAlertPolicy 'Microsoft.Sql/servers/databases/securityAlertPolicies@2020-11-01-preview' = {
  name: 'default'
  parent: database
  properties: {
    state: 'Disabled'
  }
}
