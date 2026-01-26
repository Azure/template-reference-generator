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
  properties: {
    administratorLogin: null
    administratorLoginPassword: null
    createMode: 'Default'
    minimalTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
    sslEnforcement: 'Enabled'
    storageProfile: {
      backupRetentionDays: 7
      storageAutogrow: 'Enabled'
      storageMB: 51200
    }
    version: '10.2'
  }
  sku: {
    capacity: 2
    family: 'Gen5'
    name: 'GP_Gen5_2'
    tier: 'GeneralPurpose'
  }
}

resource firewallRule 'Microsoft.DBforMariaDB/servers/firewallRules@2018-06-01' = {
  parent: server
  name: resourceName
  properties: {
    endIpAddress: '255.255.255.255'
    startIpAddress: '0.0.0.0'
  }
}
