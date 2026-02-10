@secure()
@description('The administrator login password for the SQL server')
param administratorLoginPassword string
param resourceName string = 'acctest0001'
param location string = 'westeurope'

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
    elasticPoolId: ''
    highAvailabilityReplicaCount: 0
    isLedgerOn: false
    maintenanceConfigurationId: resourceId('Microsoft.Maintenance/publicMaintenanceConfigurations', 'SQL_Default')
    zoneRedundant: false
    createMode: 'Default'
    licenseType: 'LicenseIncluded'
    minCapacity: 0
    readScale: 'Disabled'
    requestedBackupStorageRedundancy: 'Geo'
    autoPauseDelay: 0
  }
}

resource securityAlertPolicy 'Microsoft.Sql/servers/databases/securityAlertPolicies@2020-11-01-preview' = {
  name: 'default'
  parent: database
  properties: {
    state: 'Disabled'
  }
}
