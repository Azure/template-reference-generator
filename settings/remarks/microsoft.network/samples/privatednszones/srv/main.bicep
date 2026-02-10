param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  name: '${resourceName}.com'
  location: 'global'
}

resource sRV 'Microsoft.Network/privateDnsZones/SRV@2018-09-01' = {
  name: resourceName
  parent: privateDnsZone
  properties: {
    srvRecords: [
      {
        port: 8080
        priority: 10
        target: 'target2.contoso.com'
        weight: 10
      }
      {
        target: 'target1.contoso.com'
        weight: 5
        port: 8080
        priority: 1
      }
    ]
    ttl: 300
    metadata: {}
  }
}
