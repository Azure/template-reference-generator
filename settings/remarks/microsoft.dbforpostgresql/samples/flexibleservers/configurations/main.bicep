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
    highAvailability: {
      mode: 'Disabled'
    }
    version: '12'
    administratorLogin: 'adminTerraform'
    administratorLoginPassword: '${postgresqlAdministratorPassword}'
    availabilityZone: '2'
    backup: {
      geoRedundantBackup: 'Disabled'
    }
    network: {}
    storage: {
      storageSizeGB: 32
    }
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
    source: 'user-override'
    value: 'true'
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
