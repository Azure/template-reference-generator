param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: '${resourceName}.com'
  location: 'global'
}

resource mX 'Microsoft.Network/dnsZones/MX@2018-05-01' = {
  name: resourceName
  parent: dnsZone
  properties: {
    MXRecords: [
      {
        exchange: 'mail2.contoso.com'
        preference: 20
      }
      {
        exchange: 'mail1.contoso.com'
        preference: 10
      }
    ]
    TTL: 300
    metadata: {}
  }
}
