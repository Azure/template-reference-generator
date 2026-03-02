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
    restrictOutboundNetworkAccess: 'Disabled'
    trustedExternalTenants: []
    enableAutoStop: true
    enableDiskEncryption: false
    engineType: 'V2'
    enableDoubleEncryption: false
    enablePurge: false
    enableStreamingIngest: false
    publicIPType: 'IPv4'
    publicNetworkAccess: 'Enabled'
  }
}

resource database 'Microsoft.Kusto/clusters/databases@2023-05-02' = {
  name: resourceName
  location: location
  parent: cluster
  kind: 'ReadWrite'
  properties: {}
}

resource principalAssignment 'Microsoft.Kusto/clusters/databases/principalAssignments@2023-05-02' = {
  name: resourceName
  parent: database
  properties: {
    principalId: clientId
    principalType: 'App'
    role: 'Viewer'
    tenantId: tenant().tenantId
  }
}
