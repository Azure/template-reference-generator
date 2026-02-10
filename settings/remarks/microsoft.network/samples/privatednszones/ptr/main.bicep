param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  name: '230630033756174960.0.10.in-addr.arpa'
  location: 'global'
}

resource pTR 'Microsoft.Network/privateDnsZones/PTR@2018-09-01' = {
  name: resourceName
  parent: privateDnsZone
  properties: {
    ptrRecords: [
      {
        ptrdname: 'test2.contoso.com'
      }
      {
        ptrdname: 'test.contoso.com'
      }
    ]
    ttl: 300
    metadata: {}
  }
}
