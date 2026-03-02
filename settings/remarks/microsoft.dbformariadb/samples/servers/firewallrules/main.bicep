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
    family: 'Gen5'
    name: 'GP_Gen5_2'
    tier: 'GeneralPurpose'
    capacity: 2
  }
  properties: {
    storageProfile: {
      backupRetentionDays: 7
      storageAutogrow: 'Enabled'
      storageMB: 51200
    }
    version: '10.2'
    administratorLogin: '${administratorLogin}'
    administratorLoginPassword: '${administratorLoginPassword}'
    createMode: 'Default'
    minimalTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
    sslEnforcement: 'Enabled'
  }
}

resource firewallRule 'Microsoft.DBforMariaDB/servers/firewallRules@2018-06-01' = {
  name: resourceName
  parent: server
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '255.255.255.255'
  }
}
