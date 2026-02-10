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
    name: 'Standard_B1s'
    tier: 'Burstable'
  }
  properties: {
    createMode: ''
    dataEncryption: {
      type: 'SystemManaged'
    }
    highAvailability: {
      mode: 'Disabled'
    }
    network: {}
    administratorLogin: '${administratorLogin}'
    administratorLoginPassword: '${administratorLoginPassword}'
    backup: {
      backupRetentionDays: 7
      geoRedundantBackup: 'Disabled'
    }
  }
}
