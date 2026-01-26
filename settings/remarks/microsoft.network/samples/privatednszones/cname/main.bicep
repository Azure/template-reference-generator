param resourceName string = 'acctest0001'

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  name: '${resourceName}.com'
  location: 'global'
}

resource cname 'Microsoft.Network/privateDnsZones/CNAME@2018-09-01' = {
  parent: privateDnsZone
  name: resourceName
  properties: {
    cnameRecord: {
      cname: 'contoso.com'
    }
    metadata: {}
    ttl: 300
  }
}
