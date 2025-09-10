param location string = 'eastus'
param resource_name string = 'acctest0001'

resource server 'Microsoft.Sql/servers@2021-11-01' = {
  location: location
  name: resource_name
  properties: {
    administratorLogin: 'mradministrator'
    administratorLoginPassword: 'thisIsDog11'
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    version: '12.0'
  }
}

