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
    administratorLoginPassword: '${administratorLoginPassword}'
    minimalTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
    storageProfile: {
      storageAutogrow: 'Enabled'
      storageMB: 51200
      backupRetentionDays: 7
    }
    administratorLogin: '${administratorLogin}'
    createMode: 'Default'
    infrastructureEncryption: 'Disabled'
    sslEnforcement: 'Enabled'
    version: '9.5'
  }
}
