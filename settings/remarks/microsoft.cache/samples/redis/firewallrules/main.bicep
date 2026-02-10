param location string = 'westus'
param resourceName string = 'acctest0001'

resource redis 'Microsoft.Cache/redis@2024-11-01' = {
  name: resourceName
  location: location
  properties: {
    minimumTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    redisConfiguration: {
      'maxmemory-delta': '642'
      'maxmemory-policy': 'allkeys-lru'
      'maxmemory-reserved': '642'
      'preferred-data-persistence-auth-method': ''
    }
    redisVersion: '6.0'
    sku: {
      name: 'Premium'
      capacity: 1
      family: 'P'
    }
    disableAccessKeyAuthentication: false
    enableNonSslPort: false
  }
}

resource firewallRule 'Microsoft.Cache/redis/firewallRules@2024-11-01' = {
  name: '${resourceName}_fwrule'
  parent: redis
  properties: {
    endIP: '2.3.4.5'
    startIP: '1.2.3.4'
  }
}
