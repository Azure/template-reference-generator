@secure()
@description('The administrator login password for the PostgreSQL server')
param administratorLoginPassword string
param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The administrator login for the PostgreSQL server')
param administratorLogin string

resource server 'Microsoft.DBforPostgreSQL/servers@2017-12-01' = {
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
    minimalTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
    sslEnforcement: 'Enabled'
    administratorLogin: '${administratorLogin}'
    createMode: 'Default'
    infrastructureEncryption: 'Disabled'
    storageProfile: {
      storageMB: 51200
      backupRetentionDays: 7
      storageAutogrow: 'Enabled'
    }
    version: '9.6'
  }
}

resource database 'Microsoft.DBforPostgreSQL/servers/databases@2017-12-01' = {
  name: resourceName
  parent: server
  properties: {
    charset: 'UTF8'
    collation: 'English_United States.1252'
  }
}
