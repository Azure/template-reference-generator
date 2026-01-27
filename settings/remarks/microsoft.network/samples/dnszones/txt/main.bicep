param resourceName string = 'acctest0001'

resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: '${resourceName}.com'
  location: 'global'
}

resource txt 'Microsoft.Network/dnsZones/TXT@2018-05-01' = {
  parent: dnsZone
  name: resourceName
  properties: {
    TTL: 300
    TXTRecords: [
      {
        value: [
          'Quick brown fox'
        ]
      }
      {
        value: [
          'A long text......A long text......A long text......A long text......A long text......A long text......A long text......A long text......A long text......A long text......A long text......A long text......A long text......A long text......A long text.....'
          '.A long text......A long text......A long text......A long text......A long text......A long text......A long text......A long text......A long text......A long text......A long text......A long text......A long text......A long text......A long text....'
          '..A long text......A long text......A long text......A long text......A long text......A long text......A long text......A long text......A long text......A long text......A long text......A long text......'
        ]
      }
    ]
    metadata: {}
  }
}
