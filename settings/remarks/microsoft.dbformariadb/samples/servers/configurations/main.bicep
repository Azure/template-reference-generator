param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The administrator login for the MariaDB server')
param administratorLogin string
@secure()
@description('The administrator login password for the MariaDB server')
param administratorLoginPassword string

resource server 'Microsoft.DBforMariaDB/servers@2018-06-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'GP_Gen5_2'
    tier: 'GeneralPurpose'
    capacity: 2
    family: 'Gen5'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
    storageProfile: {
      backupRetentionDays: 7
      storageAutogrow: 'Enabled'
      storageMB: 51200
    }
    administratorLogin: '${administratorLogin}'
    createMode: 'Default'
    sslEnforcement: 'Enabled'
    version: '10.2'
    administratorLoginPassword: '${administratorLoginPassword}'
    minimalTlsVersion: 'TLS1_2'
  }
}

resource configuration 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  name: 'character_set_server'
  parent: server
  properties: {
    value: 'LATIN1'
  }
}
