param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The administrator login for the MySQL server')
param administratorLogin string
@secure()
@description('The administrator login password for the MySQL server')
param administratorLoginPassword string

resource server 'Microsoft.DBforMySQL/servers@2017-12-01' = {
  name: resourceName
  location: location
  sku: {
    family: 'Gen5'
    name: 'GP_Gen5_2'
    tier: 'GeneralPurpose'
    capacity: 2
  }
  properties: {
    sslEnforcement: 'Enabled'
    version: '5.7'
    createMode: 'Default'
    minimalTlsVersion: 'TLS1_2'
    storageProfile: {
      backupRetentionDays: 7
      storageAutogrow: 'Enabled'
      storageMB: 51200
    }
    administratorLogin: '${administratorLogin}'
    administratorLoginPassword: '${administratorLoginPassword}'
    infrastructureEncryption: 'Disabled'
    publicNetworkAccess: 'Enabled'
  }
}

resource configuration 'Microsoft.DBforMySQL/servers/configurations@2017-12-01' = {
  name: 'character_set_server'
  parent: server
  properties: {
    value: 'latin1'
  }
}
