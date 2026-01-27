param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator password for the MySQL flexible server')
param mysqlAdministratorPassword string

resource flexibleServer 'Microsoft.DBforMySQL/flexibleServers@2021-05-01' = {
  name: resourceName
  location: location
  properties: {
    administratorLogin: 'adminTerraform'
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
    version: '5.7'
  }
  sku: {
    name: 'Standard_B1s'
    tier: 'Burstable'
  }
}

resource firewallRule 'Microsoft.DBforMySQL/flexibleServers/firewallRules@2021-05-01' = {
  parent: flexibleServer
  name: resourceName
  properties: {
    endIpAddress: '255.255.255.255'
    startIpAddress: '0.0.0.0'
  }
}
