param resourceName string = 'acctest0001'
param location string = 'westus'

resource redis 'Microsoft.Cache/redis@2024-11-01' = {
  name: resourceName
  location: location
  properties: {
    redisConfiguration: {
      'maxmemory-policy': 'volatile-lru'
      'preferred-data-persistence-auth-method': ''
    }
    redisVersion: '6'
    sku: {
      capacity: 1
      family: 'C'
      name: 'Basic'
    }
    disableAccessKeyAuthentication: false
    enableNonSslPort: true
    minimumTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
  }
}

resource accessPolicy 'Microsoft.Cache/redis/accessPolicies@2024-11-01' = {
  name: '${resourceName}-accessPolicy'
  parent: redis
  properties: {
    permissions: '+@read +@connection +cluster|info allkeys'
  }
}
