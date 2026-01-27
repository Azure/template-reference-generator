param resourceName string = 'acctest0001'

resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: '${resourceName}.com'
  location: 'global'
}

resource ptr 'Microsoft.Network/dnsZones/PTR@2018-05-01' = {
  parent: dnsZone
  name: resourceName
  properties: {
    PTRRecords: [
      {
        ptrdname: 'hashicorp.com'
      }
      {
        ptrdname: 'microsoft.com'
      }
    ]
    TTL: 300
    metadata: {}
  }
}
