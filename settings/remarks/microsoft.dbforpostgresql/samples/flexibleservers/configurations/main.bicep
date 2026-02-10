@secure()
@description('The administrator password for the PostgreSQL flexible server')
param postgresqlAdministratorPassword string
param resourceName string = 'acctest0001'
param location string = 'eastus'

resource flexibleServer 'Microsoft.DBforPostgreSQL/flexibleServers@2023-06-01-preview' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_D2s_v3'
    tier: 'GeneralPurpose'
  }
  properties: {
    administratorLoginPassword: '${postgresqlAdministratorPassword}'
    availabilityZone: '2'
    version: '12'
    administratorLogin: 'adminTerraform'
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
  }
  identity: {
    userAssignedIdentities: null
    type: 'None'
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
    value: '40'
    source: 'user-override'
  }
}
