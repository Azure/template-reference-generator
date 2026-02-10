param location string = 'westus'
param resourceName string = 'acctest0001'

resource staticSite 'Microsoft.Web/staticSites@2021-02-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Free'
  }
  properties: {}
}

resource customDomain 'Microsoft.Web/staticSites/customDomains@2021-02-01' = {
  name: '${resourceName}.contoso.com'
  parent: staticSite
  properties: {
    validationMethod: 'dns-txt-token'
  }
}
