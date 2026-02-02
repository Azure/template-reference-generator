param resourceName string = 'acctest0001'

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  name: '${resourceName}.com'
  location: 'global'
}

resource txt 'Microsoft.Network/privateDnsZones/TXT@2018-09-01' = {
  parent: privateDnsZone
  name: resourceName
  properties: {
    metadata: {}
    ttl: 300
    txtRecords: [
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
  }
}
