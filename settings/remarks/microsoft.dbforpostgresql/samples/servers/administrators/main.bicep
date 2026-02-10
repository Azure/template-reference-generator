@description('The administrator login name for the PostgreSQL server admin')
param adminLogin string
param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The administrator login name for the PostgreSQL server')
param administratorLogin string
@secure()
@description('The administrator login password for the PostgreSQL server')
param administratorLoginPassword string

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
    createMode: 'Default'
    publicNetworkAccess: 'Enabled'
    version: '9.6'
    administratorLoginPassword: '${administratorLoginPassword}'
    infrastructureEncryption: 'Disabled'
    minimalTlsVersion: 'TLS1_2'
    sslEnforcement: 'Enabled'
    storageProfile: {
      backupRetentionDays: 7
      storageAutogrow: 'Enabled'
      storageMB: 51200
    }
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
