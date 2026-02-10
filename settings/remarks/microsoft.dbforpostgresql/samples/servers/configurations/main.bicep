param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The administrator login for the PostgreSQL server')
param administratorLogin string
@secure()
@description('The administrator login password for the PostgreSQL server')
param administratorLoginPassword string

resource server 'Microsoft.DBforPostgreSQL/servers@2017-12-01' = {
  name: resourceName
  location: location
  sku: {
    tier: 'GeneralPurpose'
    capacity: 2
    family: 'Gen5'
    name: 'GP_Gen5_2'
  }
  properties: {
    administratorLogin: '${administratorLogin}'
    minimalTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
    storageProfile: {
      backupRetentionDays: 7
      storageAutogrow: 'Enabled'
      storageMB: 51200
    }
    administratorLoginPassword: '${administratorLoginPassword}'
    createMode: 'Default'
    infrastructureEncryption: 'Disabled'
    sslEnforcement: 'Enabled'
    version: '9.6'
  }
}

resource configuration 'Microsoft.DBforPostgreSQL/servers/configurations@2017-12-01' = {
  name: 'backslash_quote'
  parent: server
  properties: {
    value: 'on'
  }
}
