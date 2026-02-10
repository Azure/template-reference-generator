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
    capacity: 2
    family: 'Gen5'
    name: 'GP_Gen5_2'
    tier: 'GeneralPurpose'
  }
  properties: {
    createMode: 'Default'
    minimalTlsVersion: 'TLS1_2'
    version: '5.7'
    infrastructureEncryption: 'Disabled'
    publicNetworkAccess: 'Enabled'
    sslEnforcement: 'Enabled'
    storageProfile: {
      storageMB: 51200
      backupRetentionDays: 7
      storageAutogrow: 'Enabled'
    }
    administratorLogin: '${administratorLogin}'
    administratorLoginPassword: '${administratorLoginPassword}'
  }
}

resource configuration 'Microsoft.DBforMySQL/servers/configurations@2017-12-01' = {
  name: 'character_set_server'
  parent: server
  properties: {
    value: 'latin1'
  }
}
