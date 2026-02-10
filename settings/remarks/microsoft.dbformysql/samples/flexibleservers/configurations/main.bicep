param resourceName string = 'acctest0001'
param location string = 'westus'
@secure()
@description('The administrator login password for the MySQL flexible server')
param administratorLoginPassword string

resource flexibleServer 'Microsoft.DBforMySQL/flexibleServers@2023-12-30' = {
  name: '${resourceName}-mysql'
  location: location
  sku: {
    name: 'Standard_B1ms'
    tier: 'Burstable'
  }
  properties: {
    dataEncryption: {
      type: 'SystemManaged'
    }
    highAvailability: {
      mode: 'Disabled'
    }
    version: '8.0.21'
    administratorLogin: 'tfadmin'
    administratorLoginPassword: '${administratorLoginPassword}'
    backup: {
      backupRetentionDays: 7
      geoRedundantBackup: 'Disabled'
    }
  }
}

resource configuration 'Microsoft.DBforMySQL/flexibleServers/configurations@2023-12-30' = {
  name: 'character_set_server'
  parent: flexibleServer
  properties: {
    value: 'utf8mb4'
  }
}
