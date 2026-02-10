param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource cluster 'Microsoft.Kusto/clusters@2023-05-02' = {
  name: resourceName
  location: location
  sku: {
    capacity: 1
    name: 'Dev(No SLA)_Standard_D11_v2'
    tier: 'Basic'
  }
  properties: {
    enableAutoStop: true
    enableDiskEncryption: false
    enablePurge: false
    enableStreamingIngest: false
    publicIPType: 'IPv4'
    publicNetworkAccess: 'Enabled'
    trustedExternalTenants: []
    enableDoubleEncryption: false
    engineType: 'V2'
    restrictOutboundNetworkAccess: 'Disabled'
  }
}
