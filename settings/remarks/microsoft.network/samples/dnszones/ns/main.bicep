param resourceName string = 'acctest0001'

resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: '${resourceName}.com'
  location: 'global'
}

resource n 'Microsoft.Network/dnsZones/NS@2018-05-01' = {
  parent: dnsZone
  name: resourceName
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
