param location string = 'westeurope'
param resource_name string = 'acctest0001'

resource database 'Microsoft.DBforMySQL/servers/databases@2017-12-01' = {
  parent: server
  name: resource_name
  properties: {
    charset: 'utf8'
    collation: 'utf8_unicode_ci'
  }
}

resource server 'Microsoft.DBforMySQL/servers@2017-12-01' = {
  location: location
  name: resource_name
  properties: {
    administratorLogin: 'acctestun'
    administratorLoginPassword: 'H@Sh1CoR3!'
    createMode: 'Default'
    infrastructureEncryption: 'Disabled'
    minimalTlsVersion: 'TLS1_1'
    publicNetworkAccess: 'Enabled'
    sslEnforcement: 'Enabled'
    storageProfile: {
      storageAutogrow: 'Enabled'
      storageMB: 51200
    }
    version: '5.7'
  }
  sku: {
    capacity: 2
    family: 'Gen5'
    name: 'GP_Gen5_2'
    tier: 'GeneralPurpose'
  }
}

