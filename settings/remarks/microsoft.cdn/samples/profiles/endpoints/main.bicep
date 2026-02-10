param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource profile 'Microsoft.Cdn/profiles@2020-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_Verizon'
  }
}

resource endpoint 'Microsoft.Cdn/profiles/endpoints@2020-09-01' = {
  name: resourceName
  location: location
  parent: profile
  properties: {
    queryStringCachingBehavior: 'IgnoreQueryString'
    isHttpAllowed: true
    isHttpsAllowed: true
    origins: [
      {
        name: 'acceptanceTestCdnOrigin1'
        properties: {
          httpsPort: 443
          hostName: 'www.contoso.com'
          httpPort: 80
        }
      }
    ]
  }
}
