param resourceName string = 'acctest0001'
param location string = 'eastus'

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
