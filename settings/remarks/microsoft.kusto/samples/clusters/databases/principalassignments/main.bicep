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
    enableDoubleEncryption: false
    publicIPType: 'IPv4'
    publicNetworkAccess: 'Enabled'
    trustedExternalTenants: []
    enableAutoStop: true
    enablePurge: false
    enableStreamingIngest: false
    engineType: 'V2'
    restrictOutboundNetworkAccess: 'Disabled'
    enableDiskEncryption: false
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
    tenantId: tenant()
  }
}
