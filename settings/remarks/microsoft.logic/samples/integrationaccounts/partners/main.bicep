param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource integrationAccount 'Microsoft.Logic/integrationAccounts@2019-05-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {}
}

resource partner 'Microsoft.Logic/integrationAccounts/partners@2019-05-01' = {
  name: resourceName
  parent: integrationAccount
  properties: {
    content: {
      b2b: {
        businessIdentities: [
          {
            value: 'FabrikamNY'
            qualifier: 'AS2Identity'
          }
        ]
      }
    }
    partnerType: 'B2B'
  }
}
