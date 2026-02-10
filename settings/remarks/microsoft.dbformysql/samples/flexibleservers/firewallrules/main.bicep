param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator password for the MySQL flexible server')
param mysqlAdministratorPassword string

resource flexibleServer 'Microsoft.DBforMySQL/flexibleServers@2021-05-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_B1s'
    tier: 'Burstable'
  }
  properties: {
    administratorLogin: 'adminTerraform'
    administratorLoginPassword: '${mysqlAdministratorPassword}'
    backup: {
      backupRetentionDays: 7
      geoRedundantBackup: 'Disabled'
    }
    dataEncryption: {
      type: 'SystemManaged'
    }
    network: {}
    createMode: ''
    highAvailability: {
      mode: 'Disabled'
    }
    version: '5.7'
  }
}

resource firewallRule 'Microsoft.DBforMySQL/flexibleServers/firewallRules@2021-05-01' = {
  name: resourceName
  parent: flexibleServer
  properties: {
    endIpAddress: '255.255.255.255'
    startIpAddress: '0.0.0.0'
  }
}
