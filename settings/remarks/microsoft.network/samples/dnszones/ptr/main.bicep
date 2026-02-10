param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: '${resourceName}.com'
  location: 'global'
}

resource pTR 'Microsoft.Network/dnsZones/PTR@2018-05-01' = {
  name: resourceName
  parent: dnsZone
  properties: {
    metadata: {}
    PTRRecords: [
      {
        ptrdname: 'hashicorp.com'
      }
      {
        ptrdname: 'microsoft.com'
      }
    ]
    TTL: 300
  }
}
