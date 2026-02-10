param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The administrator login name for the MySQL flexible server')
param administratorLogin string
@secure()
@description('The administrator login password for the MySQL flexible server')
param administratorLoginPassword string

resource flexibleServer 'Microsoft.DBforMySQL/flexibleServers@2021-05-01' = {
  name: resourceName
  location: location
  sku: {
    tier: 'Burstable'
    name: 'Standard_B1s'
  }
  properties: {
    network: {}
    version: ''
    administratorLogin: '${administratorLogin}'
    administratorLoginPassword: '${administratorLoginPassword}'
    dataEncryption: {
      type: 'SystemManaged'
    }
    backup: {
      backupRetentionDays: 7
      geoRedundantBackup: 'Disabled'
    }
    createMode: ''
    highAvailability: {
      mode: 'Disabled'
    }
  }
}

resource database 'Microsoft.DBforMySQL/flexibleServers/databases@2021-05-01' = {
  name: resourceName
  parent: flexibleServer
  properties: {
    charset: 'utf8'
    collation: 'utf8_unicode_ci'
  }
}
