param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: '${resourceName}.com'
  location: 'global'
}

resource a 'Microsoft.Network/dnsZones/A@2018-05-01' = {
  name: resourceName
  parent: dnsZone
  properties: {
    ARecords: [
      {
        ipv4Address: '1.2.4.5'
      }
      {
        ipv4Address: '1.2.3.4'
      }
    ]
    TTL: 300
    metadata: {}
    targetResource: {}
  }
}
