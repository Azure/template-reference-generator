param location string = 'westeurope'
@description('The administrator login for the MariaDB server')
param administratorLogin string
@secure()
@description('The administrator login password for the MariaDB server')
param administratorLoginPassword string
param resourceName string = 'acctest0001'

resource server 'Microsoft.DBforMariaDB/servers@2018-06-01' = {
  name: resourceName
  location: location
  sku: {
    capacity: 2
    family: 'Gen5'
    name: 'B_Gen5_2'
    tier: 'Basic'
  }
  properties: {
    administratorLogin: '${administratorLogin}'
    administratorLoginPassword: '${administratorLoginPassword}'
    minimalTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
    sslEnforcement: 'Enabled'
    version: '10.2'
    createMode: 'Default'
    storageProfile: {
      backupRetentionDays: 7
      storageAutogrow: 'Enabled'
      storageMB: 51200
    }
  }
}

resource database 'Microsoft.DBforMariaDB/servers/databases@2018-06-01' = {
  name: resourceName
  parent: server
  properties: {
    charset: 'utf8'
    collation: 'utf8_general_ci'
  }
}
