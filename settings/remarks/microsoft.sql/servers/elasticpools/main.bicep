param location string = 'westeurope'
param resource_name string = 'acctest0001'

resource elasticPool 'Microsoft.Sql/servers/elasticPools@2014-04-01' = {
  parent: server
  location: location
  name: resource_name
  properties: {
    dtu: 50
    edition: 'Basic'
    storageMB: 5000
  }
}

resource server 'Microsoft.Sql/servers@2015-05-01-preview' = {
  location: location
  name: resource_name
  properties: {
    administratorLogin: '4dm1n157r470r'
    administratorLoginPassword: '4-v3ry-53cr37-p455w0rd'
    version: '12.0'
  }
}

