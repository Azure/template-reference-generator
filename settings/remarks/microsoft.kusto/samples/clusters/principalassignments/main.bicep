param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource cluster 'Microsoft.Kusto/clusters@2023-05-02' = {
  name: resourceName
  location: location
  properties: {
    enableAutoStop: true
    enableDiskEncryption: false
    enableDoubleEncryption: false
    enablePurge: false
    enableStreamingIngest: false
    engineType: 'V2'
    publicIPType: 'IPv4'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    trustedExternalTenants: []
  }
  sku: {
    capacity: 1
    name: 'Dev(No SLA)_Standard_D11_v2'
    tier: 'Basic'
  }
}

resource principalAssignment 'Microsoft.Kusto/clusters/principalAssignments@2023-05-02' = {
  parent: cluster
  name: resourceName
  properties: {
    principalId: deployer().objectId
    principalType: 'App'
    role: 'AllDatabasesViewer'
    tenantId: deployer().tenantId
  }
}
