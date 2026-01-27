param resourceName string = 'acctest0001'
param location string = 'westus'

resource staticSite 'Microsoft.Web/staticSites@2021-02-01' = {
  name: resourceName
  location: location
  properties: {}
  sku: {
    name: 'Free'
  }
}

resource customDomain 'Microsoft.Web/staticSites/customDomains@2021-02-01' = {
  parent: staticSite
  name: '${resourceName}.contoso.com'
  properties: {
    validationMethod: 'dns-txt-token'
  }
}
