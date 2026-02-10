@description('The administrator login for the MySQL server')
param administratorLogin string
@secure()
@description('The administrator login password for the MySQL server')
param administratorLoginPassword string
param resourceName string = 'acctest0001'
param location string = 'westeurope'

param clientId string

resource server 'Microsoft.DBforMySQL/servers@2017-12-01' = {
  name: resourceName
  location: location
  sku: {
    tier: 'GeneralPurpose'
    capacity: 2
    family: 'Gen5'
    name: 'GP_Gen5_2'
  }
  properties: {
    minimalTlsVersion: 'TLS1_2'
    sslEnforcement: 'Enabled'
    storageProfile: {
      backupRetentionDays: 7
      storageAutogrow: 'Enabled'
      storageMB: 51200
    }
    createMode: 'Default'
    publicNetworkAccess: 'Enabled'
    version: '5.7'
    administratorLogin: '${administratorLogin}'
    administratorLoginPassword: '${administratorLoginPassword}'
    infrastructureEncryption: 'Disabled'
  }
}

resource administrator 'Microsoft.DBforMySQL/servers/administrators@2017-12-01' = {
  name: 'activeDirectory'
  parent: server
  properties: {
    tenantId: tenant().tenantId
    administratorType: 'ActiveDirectory'
    login: 'sqladmin'
    sid: clientId
  }
}
