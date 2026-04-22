param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: '${resourceName}.com'
  location: 'global'
}

resource sRV 'Microsoft.Network/dnsZones/SRV@2018-05-01' = {
  name: resourceName
  parent: dnsZone
  properties: {
    SRVRecords: [
      {
        port: 8080
        priority: 2
        target: 'target2.contoso.com'
        weight: 25
      }
      {
        port: 8080
        priority: 1
        target: 'target1.contoso.com'
        weight: 5
      }
    ]
    TTL: 300
    metadata: {}
  }
}
