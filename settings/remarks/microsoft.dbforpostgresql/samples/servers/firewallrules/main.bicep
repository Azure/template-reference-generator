@secure()
@description('The administrator login password for the PostgreSQL server')
param administratorLoginPassword string
param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The administrator login for the PostgreSQL server')
param administratorLogin string

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
    storageProfile: {
      backupRetentionDays: 7
      storageAutogrow: 'Enabled'
      storageMB: 51200
    }
    version: '9.6'
    infrastructureEncryption: 'Disabled'
    sslEnforcement: 'Enabled'
  }
}

resource firewallRule 'Microsoft.DBforPostgreSQL/servers/firewallRules@2017-12-01' = {
  name: resourceName
  parent: server
  properties: {
    endIpAddress: '255.255.255.255'
    startIpAddress: '0.0.0.0'
  }
}
