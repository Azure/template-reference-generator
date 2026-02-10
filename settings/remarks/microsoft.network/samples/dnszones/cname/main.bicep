param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: '${resourceName}.com'
  location: 'global'
}

resource cNAME 'Microsoft.Network/dnsZones/CNAME@2018-05-01' = {
  name: resourceName
  parent: dnsZone
  properties: {
    CNAMERecord: {
      cname: '${resourceName}.webpubsub.azure.com'
    }
    TTL: 3600
    metadata: {}
    targetResource: {}
  }
}
