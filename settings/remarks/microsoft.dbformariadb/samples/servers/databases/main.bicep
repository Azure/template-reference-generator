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
    tier: 'Basic'
    capacity: 2
    family: 'Gen5'
    name: 'B_Gen5_2'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
    sslEnforcement: 'Enabled'
    administratorLogin: '${administratorLogin}'
    administratorLoginPassword: '${administratorLoginPassword}'
    minimalTlsVersion: 'TLS1_2'
    storageProfile: {
      storageAutogrow: 'Enabled'
      storageMB: 51200
      backupRetentionDays: 7
    }
    version: '10.2'
    createMode: 'Default'
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
