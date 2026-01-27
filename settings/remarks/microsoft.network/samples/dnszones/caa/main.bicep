param resourceName string = 'acctest0001'

resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: '${resourceName}.com'
  location: 'global'
}

resource caa 'Microsoft.Network/dnsZones/CAA@2018-05-01' = {
  parent: dnsZone
  name: resourceName
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
        flags: 0
        tag: 'issue'
        value: 'example.net'
      }
    ]
    metadata: {}
  }
}
