param resourceName string = 'acctest0001'
param location string = 'westus'

resource redisPrimary 'Microsoft.Cache/redis@2024-11-01' = {
  name: '${resourceName}-primary'
  location: location
  properties: {
    disableAccessKeyAuthentication: false
    enableNonSslPort: false
    minimumTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    redisConfiguration: {
      'preferred-data-persistence-auth-method': ''
      'maxmemory-delta': '642'
      'maxmemory-policy': 'allkeys-lru'
      'maxmemory-reserved': '642'
    }
    redisVersion: '6'
    sku: {
      capacity: 1
      family: 'P'
      name: 'Premium'
    }
  }
}

resource redisSecondary 'Microsoft.Cache/redis@2024-11-01' = {
  name: '${resourceName}-secondary'
  location: location
  properties: {
    redisConfiguration: {
      'maxmemory-delta': '642'
      'maxmemory-policy': 'allkeys-lru'
      'maxmemory-reserved': '642'
      'preferred-data-persistence-auth-method': ''
    }
    redisVersion: '6'
    sku: {
      capacity: 1
      family: 'P'
      name: 'Premium'
    }
    disableAccessKeyAuthentication: false
    enableNonSslPort: false
    minimumTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
  }
}

resource linkedServer 'Microsoft.Cache/redis/linkedServers@2024-11-01' = {
  name: '${resourceName}-secondary'
  parent: redisPrimary
  properties: {
    linkedRedisCacheId: redisSecondary.id
    linkedRedisCacheLocation: location
    serverRole: 'Secondary'
  }
}
