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
  properties: {
    administratorLogin: null
    administratorLoginPassword: null
    backup: {
      backupRetentionDays: 7
      geoRedundantBackup: 'Disabled'
    }
    createMode: ''
    dataEncryption: {
      type: 'SystemManaged'
    }
    highAvailability: {
      mode: 'Disabled'
    }
    network: {}
    version: ''
  }
  sku: {
    name: 'Standard_B1s'
    tier: 'Burstable'
  }
}

resource database 'Microsoft.DBforMySQL/flexibleServers/databases@2021-05-01' = {
  parent: flexibleServer
  name: resourceName
  properties: {
    charset: 'utf8'
    collation: 'utf8_unicode_ci'
  }
}
