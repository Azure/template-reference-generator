param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource resourceProvider 'Microsoft.CustomProviders/resourceProviders@2018-09-01-preview' = {
  name: resourceName
  location: location
  properties: {
    resourceTypes: [
      {
        name: 'dEf1'
        routingType: 'Proxy'
        endpoint: 'https://example.com/'
      }
    ]
  }
}
