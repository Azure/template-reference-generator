param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The administrator login for the MySQL server')
param administratorLogin string
@secure()
@description('The administrator login password for the MySQL server')
param administratorLoginPassword string

resource server 'Microsoft.DBforMySQL/servers@2017-12-01' = {
  name: resourceName
  location: location
  sku: {
    family: 'Gen5'
    name: 'GP_Gen5_2'
    tier: 'GeneralPurpose'
    capacity: 2
  }
  properties: {
    version: '5.7'
    createMode: 'Default'
    publicNetworkAccess: 'Enabled'
    sslEnforcement: 'Enabled'
    administratorLogin: '${administratorLogin}'
    administratorLoginPassword: '${administratorLoginPassword}'
    infrastructureEncryption: 'Disabled'
    minimalTlsVersion: 'TLS1_2'
    storageProfile: {
      storageAutogrow: 'Enabled'
      storageMB: 51200
      backupRetentionDays: 7
    }
  }
}

resource firewallRule 'Microsoft.DBforMySQL/servers/firewallRules@2017-12-01' = {
  name: resourceName
  parent: server
  properties: {
    endIpAddress: '255.255.255.255'
    startIpAddress: '0.0.0.0'
  }
}
