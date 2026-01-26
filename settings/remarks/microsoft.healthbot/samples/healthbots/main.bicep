param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource healthBot 'Microsoft.HealthBot/healthBots@2022-08-08' = {
  name: resourceName
  location: location
  sku: {
    name: 'F0'
  }
}
