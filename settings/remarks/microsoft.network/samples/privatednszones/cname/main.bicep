param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  name: '${resourceName}.com'
  location: 'global'
}

resource cNAME 'Microsoft.Network/privateDnsZones/CNAME@2018-09-01' = {
  name: resourceName
  parent: privateDnsZone
  properties: {
    metadata: {}
    ttl: 300
    cnameRecord: {
      cname: 'contoso.com'
    }
  }
}
