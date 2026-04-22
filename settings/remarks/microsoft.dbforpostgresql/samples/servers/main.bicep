param location string = 'westeurope'
@description('The administrator login name for the PostgreSQL server')
param administratorLogin string
@secure()
@description('The administrator login password for the PostgreSQL server')
param administratorLoginPassword string
param resourceName string = 'acctest0001'

resource server 'Microsoft.DBforPostgreSQL/servers@2017-12-01' = {
  name: resourceName
  location: location
  sku: {
    family: 'Gen5'
    name: 'GP_Gen5_2'
    tier: 'GeneralPurpose'
    capacity: 2
  }
  properties: {
    minimalTlsVersion: 'TLS1_2'
    sslEnforcement: 'Enabled'
    administratorLoginPassword: '${administratorLoginPassword}'
    createMode: 'Default'
    publicNetworkAccess: 'Enabled'
    storageProfile: {
      backupRetentionDays: 7
      storageAutogrow: 'Enabled'
      storageMB: 51200
    }
    version: '9.5'
    administratorLogin: '${administratorLogin}'
    infrastructureEncryption: 'Disabled'
  }
}
