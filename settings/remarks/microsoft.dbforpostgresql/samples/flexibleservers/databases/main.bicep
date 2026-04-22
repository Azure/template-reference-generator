param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator password for the PostgreSQL flexible server')
param postgresqlAdministratorPassword string

resource flexibleServer 'Microsoft.DBforPostgreSQL/flexibleServers@2022-12-01' = {
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
    network: {}
    version: '12'
    administratorLoginPassword: '${postgresqlAdministratorPassword}'
    highAvailability: {
      mode: 'Disabled'
    }
    storage: {
      storageSizeGB: 32
    }
    administratorLogin: 'adminTerraform'
    availabilityZone: '2'
  }
}

resource database 'Microsoft.DBforPostgreSQL/flexibleServers/databases@2022-12-01' = {
  name: resourceName
  parent: flexibleServer
  properties: {
    charset: 'UTF8'
    collation: 'en_US.UTF8'
  }
}
