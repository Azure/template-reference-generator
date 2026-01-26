param resourceName string = 'acctest0001'

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  name: '${resourceName}.com'
  location: 'global'
}

resource a 'Microsoft.Network/privateDnsZones/A@2018-09-01' = {
  parent: privateDnsZone
  name: resourceName
  properties: {
    aRecords: [
      {
        ipv4Address: '1.2.4.5'
      }
      {
        ipv4Address: '1.2.3.4'
      }
    ]
    metadata: {}
    ttl: 300
  }
}
