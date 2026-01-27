param resourceName string = 'acctest0001'

resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: '${resourceName}.com'
  location: 'global'
}

resource mx 'Microsoft.Network/dnsZones/MX@2018-05-01' = {
  parent: dnsZone
  name: resourceName
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
