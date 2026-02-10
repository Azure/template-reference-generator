param location string = 'westeurope'
@description('The administrator login for the MySQL server')
param administratorLogin string
@secure()
@description('The administrator login password for the MySQL server')
param administratorLoginPassword string
param resourceName string = 'acctest0001'

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
    administratorLoginPassword: '${administratorLoginPassword}'
    createMode: 'Default'
    infrastructureEncryption: 'Disabled'
    sslEnforcement: 'Enabled'
    version: '5.7'
    minimalTlsVersion: 'TLS1_1'
    publicNetworkAccess: 'Enabled'
    storageProfile: {
      storageAutogrow: 'Enabled'
      storageMB: 51200
    }
    administratorLogin: '${administratorLogin}'
  }
}

resource database 'Microsoft.DBforMySQL/servers/databases@2017-12-01' = {
  name: resourceName
  parent: server
  properties: {
    charset: 'utf8'
    collation: 'utf8_unicode_ci'
  }
}
