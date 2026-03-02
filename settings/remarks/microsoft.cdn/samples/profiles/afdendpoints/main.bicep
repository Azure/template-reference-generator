param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource profile 'Microsoft.Cdn/profiles@2021-06-01' = {
  name: resourceName
  location: 'global'
  sku: {
    name: 'Standard_AzureFrontDoor'
  }
  properties: {
    originResponseTimeoutSeconds: 120
  }
}

resource afdEndpoint 'Microsoft.Cdn/profiles/afdEndpoints@2021-06-01' = {
  name: resourceName
  location: 'global'
  parent: profile
  properties: {
    enabledState: 'Enabled'
  }
}
