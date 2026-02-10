param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: '${resourceName}.com'
  location: 'global'
}

resource cAA 'Microsoft.Network/dnsZones/CAA@2018-05-01' = {
  name: resourceName
  parent: dnsZone
  properties: {
    TTL: 300
    caaRecords: [
      {
        flags: 1
        tag: 'issuewild'
        value: ';'
      }
      {
        flags: 0
        tag: 'iodef'
        value: 'mailto:terraform@nonexist.tld'
      }
      {
        flags: 0
        tag: 'issue'
        value: 'example.com'
      }
      {
        value: 'example.net'
        flags: 0
        tag: 'issue'
      }
    ]
    metadata: {}
  }
}
