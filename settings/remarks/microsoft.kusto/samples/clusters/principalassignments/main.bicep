param resourceName string = 'acctest0001'
param location string = 'westeurope'

param clientId string

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
    enableDoubleEncryption: false
    enableStreamingIngest: false
    publicIPType: 'IPv4'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    enableDiskEncryption: false
    enablePurge: false
    engineType: 'V2'
    trustedExternalTenants: []
  }
}

resource principalAssignment 'Microsoft.Kusto/clusters/principalAssignments@2023-05-02' = {
  name: resourceName
  parent: cluster
  properties: {
    principalId: clientId
    principalType: 'App'
    role: 'AllDatabasesViewer'
    tenantId: tenant().tenantId
  }
}
