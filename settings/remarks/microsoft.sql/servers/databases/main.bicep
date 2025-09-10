param location string = 'westeurope'
param resource_name string = 'acctest0001'

resource database 'Microsoft.Sql/servers/databases@2014-04-01' = {
  parent: server
  location: location
  name: resource_name
  properties: {
    collation: 'SQL_LATIN1_GENERAL_CP1_CI_AS'
    createMode: 'Default'
    maxSizeBytes: '268435456000'
    readScale: 'Disabled'
    requestedServiceObjectiveName: 'S0'
    zoneRedundant: false
  }
}

resource server 'Microsoft.Sql/servers@2015-05-01-preview' = {
  location: location
  name: resource_name
  properties: {
    administratorLogin: 'acctestadmin'
    administratorLoginPassword: 't2RX8A76GrnE4EKC'
    version: '12.0'
  }
}

