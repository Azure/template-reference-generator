param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The administrator login name for the PostgreSQL server')
param administratorLogin string
@secure()
@description('The administrator login password for the PostgreSQL server')
param administratorLoginPassword string
@description('The administrator login name for the PostgreSQL server admin')
param adminLogin string

param clientId string

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
    administratorLogin: '${administratorLogin}'
    administratorLoginPassword: '${administratorLoginPassword}'
    createMode: 'Default'
    minimalTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
    sslEnforcement: 'Enabled'
    storageProfile: {
      storageAutogrow: 'Enabled'
      storageMB: 51200
      backupRetentionDays: 7
    }
    version: '9.6'
    infrastructureEncryption: 'Disabled'
  }
}

resource administrator 'Microsoft.DBforPostgreSQL/servers/administrators@2017-12-01' = {
  name: 'activeDirectory'
  parent: server
  properties: {
    administratorType: 'ActiveDirectory'
    login: adminLogin
    sid: clientId
    tenantId: tenant().tenantId
  }
}
