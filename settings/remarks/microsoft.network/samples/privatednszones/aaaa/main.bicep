param resourceName string = 'acctest0001'

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  name: '${resourceName}.com'
  location: 'global'
}

resource aaaa 'Microsoft.Network/privateDnsZones/AAAA@2018-09-01' = {
  parent: privateDnsZone
  name: resourceName
  properties: {
    aaaaRecords: [
      {
        ipv6Address: 'fd5d:70bc:930e:d008:0000:0000:0000:7334'
      }
      {
        ipv6Address: 'fd5d:70bc:930e:d008::7335'
      }
    ]
    metadata: {}
    ttl: 300
  }
}
