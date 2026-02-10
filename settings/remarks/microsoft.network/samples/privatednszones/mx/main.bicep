param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  name: '${resourceName}.com'
  location: 'global'
}

resource mX 'Microsoft.Network/privateDnsZones/MX@2018-09-01' = {
  name: resourceName
  parent: privateDnsZone
  properties: {
    metadata: {}
    mxRecords: [
      {
        exchange: 'mx1.contoso.com'
        preference: 10
      }
      {
        exchange: 'mx2.contoso.com'
        preference: 10
      }
    ]
    ttl: 300
  }
}
