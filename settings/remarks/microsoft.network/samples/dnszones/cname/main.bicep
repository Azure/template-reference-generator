param resourceName string = 'acctest0001'

resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: '${resourceName}.com'
  location: 'global'
}

resource cname 'Microsoft.Network/dnsZones/CNAME@2018-05-01' = {
  parent: dnsZone
  name: resourceName
  properties: {
    CNAMERecord: {
      cname: 'acctest0001.webpubsub.azure.com'
    }
    TTL: 3600
    metadata: {}
    targetResource: {}
  }
}
