targetScope = 'subscription'

param resourceName string = 'acctest0003'
param location string = 'westeurope'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: resourceName
  location: location
}

resource b2cDirectory 'Microsoft.AzureActiveDirectory/b2cDirectories@2021-04-01-preview' = {
  name: '${resourceName}.onmicrosoft.com'
  sku: {
    name: 'PremiumP1'
    tier: 'A0'
  }
  properties: {
    createTenantProperties: {
      countryCode: 'US'
      displayName: '${resourceName}'
    }
  }
}
