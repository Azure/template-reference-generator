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
    highAvailability: {
      mode: 'Disabled'
    }
    administratorLogin: 'adminTerraform'
    network: {}
    storage: {
      storageSizeGB: 32
    }
    version: '12'
    administratorLoginPassword: '${postgresqlAdministratorPassword}'
    availabilityZone: '2'
  }
}

resource firewallRule 'Microsoft.DBforPostgreSQL/flexibleServers/firewallRules@2022-12-01' = {
  name: resourceName
  parent: flexibleServer
  properties: {
    endIpAddress: '122.122.0.0'
    startIpAddress: '122.122.0.0'
  }
}
