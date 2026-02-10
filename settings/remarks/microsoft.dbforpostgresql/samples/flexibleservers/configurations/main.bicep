param resourceName string = 'acctest0001'
param location string = 'eastus'
@secure()
@description('The administrator password for the PostgreSQL flexible server')
param postgresqlAdministratorPassword string

resource flexibleServer 'Microsoft.DBforPostgreSQL/flexibleServers@2023-06-01-preview' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_D2s_v3'
    tier: 'GeneralPurpose'
  }
  properties: {
    backup: {
      geoRedundantBackup: 'Disabled'
    }
    storage: {
      storageSizeGB: 32
    }
    administratorLogin: 'adminTerraform'
    administratorLoginPassword: '${postgresqlAdministratorPassword}'
    availabilityZone: '2'
    highAvailability: {
      mode: 'Disabled'
    }
    network: {}
    version: '12'
  }
  identity: {
    type: 'None'
    userAssignedIdentities: null
  }
}

resource pgbouncerEnabled 'Microsoft.DBforPostgreSQL/flexibleServers/configurations@2022-12-01' = {
  name: 'pgbouncer.enabled'
  parent: flexibleServer
  properties: {
    value: 'true'
    source: 'user-override'
  }
}

resource pgbouncerDefaultPoolSize 'Microsoft.DBforPostgreSQL/flexibleServers/configurations@2022-12-01' = {
  name: 'pgbouncer.default_pool_size'
  parent: flexibleServer
  dependsOn: [
    pgbouncerEnabled
  ]
  properties: {
    source: 'user-override'
    value: '40'
  }
}
