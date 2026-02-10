param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource profile 'Microsoft.Cdn/profiles@2021-06-01' = {
  name: resourceName
  location: 'global'
  sku: {
    name: 'Premium_AzureFrontDoor'
  }
  properties: {
    originResponseTimeoutSeconds: 120
  }
}

resource customDomain 'Microsoft.Cdn/profiles/customDomains@2021-06-01' = {
  name: resourceName
  parent: profile
  properties: {
    azureDnsZone: {
      id: dnsZone.id
    }
    hostName: 'fabrikam.${resourceName}.com'
    tlsSettings: {
      minimumTlsVersion: 'TLS12'
      certificateType: 'ManagedCertificate'
    }
  }
}

resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: '${resourceName}.com'
  location: 'global'
}
