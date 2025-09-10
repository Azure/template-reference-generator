param location string = 'westeurope'
param resource_name string = 'acctest0001'

resource server 'Microsoft.Sql/servers@2015-05-01-preview' = {
  location: location
  name: resource_name
  properties: {
    administratorLogin: 'acctestadmin'
    administratorLoginPassword: 't2RX8A76GrnE4EKC'
    version: '12.0'
  }
}

