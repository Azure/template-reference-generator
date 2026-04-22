@secure()
@description('The administrator login password for the SQL server')
param administratorLoginPassword string
param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource server 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: resourceName
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

resource database 'Microsoft.Sql/servers/databases@2021-02-01-preview' = {
  name: resourceName
  location: location
  parent: server
  properties: {
    autoPauseDelay: 0
    elasticPoolId: ''
    licenseType: 'LicenseIncluded'
    maintenanceConfigurationId: resourceId('Microsoft.Maintenance/publicMaintenanceConfigurations', 'SQL_Default')
    minCapacity: 0
    createMode: 'Default'
    highAvailabilityReplicaCount: 0
    isLedgerOn: false
    readScale: 'Disabled'
    requestedBackupStorageRedundancy: 'Geo'
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
