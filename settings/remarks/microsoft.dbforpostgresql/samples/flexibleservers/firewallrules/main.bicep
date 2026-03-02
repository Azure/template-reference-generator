@secure()
@description('The administrator password for the PostgreSQL flexible server')
param postgresqlAdministratorPassword string
param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource flexibleServer 'Microsoft.DBforPostgreSQL/flexibleServers@2022-12-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_D2s_v3'
    tier: 'GeneralPurpose'
  }
  properties: {
    administratorLoginPassword: '${postgresqlAdministratorPassword}'
    availabilityZone: '2'
    highAvailability: {
      mode: 'Disabled'
    }
    version: '12'
    administratorLogin: 'adminTerraform'
    backup: {
      geoRedundantBackup: 'Disabled'
    }
    network: {}
    storage: {
      storageSizeGB: 32
    }
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
