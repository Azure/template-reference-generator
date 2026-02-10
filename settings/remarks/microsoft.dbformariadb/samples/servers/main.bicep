param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The administrator login name for the MariaDB server')
param administratorLogin string
@secure()
@description('The administrator login password for the MariaDB server')
param administratorLoginPassword string

resource server 'Microsoft.DBforMariaDB/servers@2018-06-01' = {
  name: resourceName
  location: location
  sku: {
    capacity: 2
    family: 'Gen5'
    name: 'GP_Gen5_2'
    tier: 'GeneralPurpose'
  }
  properties: {
    sslEnforcement: 'Enabled'
    storageProfile: {
      storageMB: 51200
      backupRetentionDays: 7
      storageAutogrow: 'Enabled'
    }
    version: '10.2'
    administratorLoginPassword: '${administratorLoginPassword}'
    createMode: 'Default'
    minimalTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
    administratorLogin: '${administratorLogin}'
  }
}
