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
    name: 'GP_Gen5_2'
    tier: 'GeneralPurpose'
    capacity: 2
    family: 'Gen5'
  }
  properties: {
    administratorLoginPassword: '${administratorLoginPassword}'
    infrastructureEncryption: 'Disabled'
    minimalTlsVersion: 'TLS1_1'
    publicNetworkAccess: 'Enabled'
    sslEnforcement: 'Enabled'
    storageProfile: {
      storageMB: 51200
      storageAutogrow: 'Enabled'
    }
    administratorLogin: '${administratorLogin}'
    createMode: 'Default'
    version: '5.7'
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
