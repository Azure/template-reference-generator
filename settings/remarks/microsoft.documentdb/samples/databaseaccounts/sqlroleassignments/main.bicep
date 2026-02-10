param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource sqlRoleDefinition 'Microsoft.DocumentDB/databaseAccounts/sqlRoleDefinitions@2021-10-15' existing = {
  name: '00000000-0000-0000-0000-000000000001'
  parent: databaseAccount
}

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
    enablePurge: false
    engineType: 'V2'
    restrictOutboundNetworkAccess: 'Disabled'
    enableDiskEncryption: false
    enableDoubleEncryption: false
    enableStreamingIngest: false
    publicIPType: 'IPv4'
    publicNetworkAccess: 'Enabled'
    trustedExternalTenants: []
  }
}

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    databaseAccountOfferType: 'Standard'
    disableKeyBasedMetadataWriteAccess: false
    disableLocalAuth: false
    enableAnalyticalStorage: false
    capabilities: []
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
    }
    enableAutomaticFailover: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    networkAclBypass: 'None'
    networkAclBypassResourceIds: []
    enableFreeTier: false
    enableMultipleWriteLocations: false
    virtualNetworkRules: []
    defaultIdentity: 'FirstPartyIdentity'
    ipRules: []
    isVirtualNetworkFilterEnabled: false
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

resource sqlRoleAssignment 'Microsoft.DocumentDB/databaseAccounts/sqlRoleAssignments@2021-10-15' = {
  name: 'ff419bf7-f8ca-ef51-00d2-3576700c341b'
  parent: databaseAccount
  properties: {
    principalId: cluster.identity.principalId
    roleDefinitionId: sqlRoleDefinition.id
    scope: databaseAccount.id
  }
}
