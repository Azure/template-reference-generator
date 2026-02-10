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
    publicIPType: 'IPv4'
    restrictOutboundNetworkAccess: 'Disabled'
    enableDoubleEncryption: false
    enableStreamingIngest: false
    engineType: 'V2'
    publicNetworkAccess: 'Enabled'
    trustedExternalTenants: []
    enableAutoStop: true
    enableDiskEncryption: false
    enablePurge: false
  }
}

resource principalAssignment 'Microsoft.Kusto/clusters/principalAssignments@2023-05-02' = {
  name: resourceName
  parent: cluster
  properties: {
    tenantId: tenant()
    principalId: clientId
    principalType: 'App'
    role: 'AllDatabasesViewer'
  }
}
