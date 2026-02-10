param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource cluster 'Microsoft.Kusto/clusters@2023-05-02' = {
  name: resourceName
  location: location
  sku: {
    name: 'Dev(No SLA)_Standard_D11_v2'
    tier: 'Basic'
    capacity: 1
  }
  properties: {
    enableDoubleEncryption: false
    publicIPType: 'IPv4'
    publicNetworkAccess: 'Enabled'
    trustedExternalTenants: []
    enablePurge: false
    enableStreamingIngest: false
    engineType: 'V2'
    restrictOutboundNetworkAccess: 'Disabled'
    enableAutoStop: true
    enableDiskEncryption: false
  }
}
