param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: '${resourceName}.com'
  location: 'global'
}

resource n 'Microsoft.Network/dnsZones/NS@2018-05-01' = {
  name: resourceName
  parent: dnsZone
  properties: {
    NSRecords: [
      {
        nsdname: 'ns1.contoso.com'
      }
      {
        nsdname: 'ns2.contoso.com'
      }
    ]
    TTL: 300
    metadata: {}
  }
}
