param resourceName string = 'acctest0001'

resource profile 'Microsoft.Cdn/profiles@2021-06-01' = {
  name: resourceName
  location: 'global'
  properties: {
    originResponseTimeoutSeconds: 120
  }
  sku: {
    name: 'Standard_AzureFrontDoor'
  }
}

resource ruleSet 'Microsoft.Cdn/profiles/ruleSets@2021-06-01' = {
  parent: profile
  name: resourceName
}
