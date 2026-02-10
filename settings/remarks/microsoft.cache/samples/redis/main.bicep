param location string = 'eastus'
param resourceName string = 'acctest0001'

resource redis 'Microsoft.Cache/redis@2023-04-01' = {
  name: resourceName
  location: location
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
