param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator login password for the SQL server')
param administratorLoginPassword string

resource server 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: resourceName
  location: location
  properties: {
    administratorLoginPassword: '${administratorLoginPassword}'
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    version: '12.0'
    administratorLogin: '4dm1n157r470r'
  }
}

resource elasticPool 'Microsoft.Sql/servers/elasticPools@2020-11-01-preview' = {
  name: resourceName
  location: location
  parent: server
  sku: {
    name: 'BasicPool'
    tier: 'Basic'
    capacity: 50
    family: ''
  }
  properties: {
    maintenanceConfigurationId: resourceId('Microsoft.Maintenance/publicMaintenanceConfigurations', 'SQL_Default')
    maxSizeBytes: 5242880000
    perDatabaseSettings: {
      maxCapacity: 5
      minCapacity: 0
    }
    zoneRedundant: false
  }
}
