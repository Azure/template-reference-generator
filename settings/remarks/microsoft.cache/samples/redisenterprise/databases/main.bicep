param resourceName string = 'acctest0001'
param location string = 'westus'

resource redisEnterprise 'Microsoft.Cache/redisEnterprise@2025-04-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Balanced_B0'
  }
  properties: {
    minimumTlsVersion: '1.2'
    encryption: {}
    highAvailability: 'Enabled'
  }
}

resource defaultDatabase 'Microsoft.Cache/redisEnterprise/databases@2025-04-01' = {
  name: 'default'
  parent: redisEnterprise
  properties: {
    port: 10000
    clientProtocol: 'Encrypted'
    clusteringPolicy: 'OSSCluster'
    evictionPolicy: 'VolatileLRU'
    modules: []
  }
}
