param resourceName string = 'acctest0001'
param location string = 'eastus'
@secure()
@description('The administrator password for the PostgreSQL flexible server')
param postgresqlAdministratorPassword string

resource flexibleServer 'Microsoft.DBforPostgreSQL/flexibleServers@2023-06-01-preview' = {
  name: resourceName
  location: location
  identity: {
    type: 'None'
    userAssignedIdentities: null
  }
  properties: {
    administratorLogin: 'adminTerraform'
    administratorLoginPassword: null
    availabilityZone: '2'
    backup: {
      geoRedundantBackup: 'Disabled'
    }
    highAvailability: {
      mode: 'Disabled'
    }
    network: {}
    storage: {
      storageSizeGB: 32
    }
    version: '12'
  }
  sku: {
    name: 'Standard_D2s_v3'
    tier: 'GeneralPurpose'
  }
}

resource pgbouncerDefaultPoolSize 'Microsoft.DBforPostgreSQL/flexibleServers/configurations@2022-12-01' = {
  parent: flexibleServer
  name: 'pgbouncer.default_pool_size'
  properties: {
    source: 'user-override'
    value: '40'
  }
  dependsOn: [
    pgbouncerEnabled
  ]
}

resource pgbouncerEnabled 'Microsoft.DBforPostgreSQL/flexibleServers/configurations@2022-12-01' = {
  parent: flexibleServer
  name: 'pgbouncer.enabled'
  properties: {
    source: 'user-override'
    value: 'true'
  }
}
