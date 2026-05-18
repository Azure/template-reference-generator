param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource integrationAccount 'Microsoft.Logic/integrationAccounts@2019-05-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {}
}

resource session 'Microsoft.Logic/integrationAccounts/sessions@2019-05-01' = {
  name: resourceName
  parent: integrationAccount
  properties: {
    content: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
  }
}
