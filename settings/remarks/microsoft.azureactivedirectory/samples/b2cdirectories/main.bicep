targetScope = 'subscription'

param resourceName string = 'acctest0003'
param location string = 'westeurope'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: resourceName
  location: location
}

resource b2cDirectory 'Microsoft.AzureActiveDirectory/b2cDirectories@2021-04-01-preview' = {
  name: '${resourceName}.onmicrosoft.com'
  location: 'United States'
  properties: {
    createTenantProperties: {
      countryCode: 'US'
      displayName: 'acctest0003'
    }
  }
  sku: {
    name: 'PremiumP1'
    tier: 'A0'
  }
}
