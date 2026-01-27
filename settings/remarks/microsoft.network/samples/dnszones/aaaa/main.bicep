param resourceName string = 'acctest0001'

resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: '${resourceName}.com'
  location: 'global'
}

resource aaaa 'Microsoft.Network/dnsZones/AAAA@2018-05-01' = {
  parent: dnsZone
  name: resourceName
  properties: {
    AAAARecords: [
      {
        ipv6Address: '2607:f8b0:4009:1803::1005'
      }
      {
        ipv6Address: '2607:f8b0:4009:1803::1006'
      }
    ]
    TTL: 300
    metadata: {}
    targetResource: {}
  }
}
