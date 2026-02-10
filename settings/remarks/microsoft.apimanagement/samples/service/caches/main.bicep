param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource service 'Microsoft.ApiManagement/service@2021-08-01' = {
  name: resourceName
  location: location
  sku: {
    capacity: 0
    name: 'Consumption'
  }
  properties: {
    publisherEmail: 'pub1@email.com'
    publisherName: 'pub1'
    virtualNetworkType: 'None'
    certificates: []
    customProperties: {
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Ssl30': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls10': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls11': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls10': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls11': 'false'
    }
    disableGateway: false
    publicNetworkAccess: 'Enabled'
  }
}

resource cache 'Microsoft.ApiManagement/service/caches@2021-08-01' = {
  name: resourceName
  parent: service
  properties: {
    connectionString: '${redis.name}.redis.cache.windows.net:6380,password=${redis.listKeys().primaryKey},ssl=true,abortConnect=False'
    useFromLocation: 'default'
  }
}

resource redis 'Microsoft.Cache/redis@2023-04-01' = {
  name: resourceName
  location: 'eastus'
  properties: {
    enableNonSslPort: true
    minimumTlsVersion: '1.2'
    sku: {
      capacity: 2
      family: 'C'
      name: 'Standard'
    }
  }
}
