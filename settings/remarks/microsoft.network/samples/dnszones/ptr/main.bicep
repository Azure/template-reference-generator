param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: '${resourceName}.com'
  location: 'global'
}

resource pTR 'Microsoft.Network/dnsZones/PTR@2018-05-01' = {
  name: resourceName
  parent: dnsZone
  properties: {
    TTL: 300
    metadata: {}
    PTRRecords: [
      {
        ptrdname: 'hashicorp.com'
      }
      {
        ptrdname: 'microsoft.com'
      }
    ]
  }
}
