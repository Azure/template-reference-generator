param resourceName string = 'acctest0001'
param location string = 'westus'

resource redisEnterprise 'Microsoft.Cache/redisEnterprise@2025-04-01' = {
  name: resourceName
  location: location
  properties: {
    encryption: {}
    highAvailability: 'Enabled'
    minimumTlsVersion: '1.2'
  }
  sku: {
    name: 'Balanced_B0'
  }
}

resource defaultDatabase 'Microsoft.Cache/redisEnterprise/databases@2025-04-01' = {
  parent: redisEnterprise
  name: 'default'
  properties: {
    clientProtocol: 'Encrypted'
    clusteringPolicy: 'OSSCluster'
    evictionPolicy: 'VolatileLRU'
    modules: []
    port: 10000
  }
}
