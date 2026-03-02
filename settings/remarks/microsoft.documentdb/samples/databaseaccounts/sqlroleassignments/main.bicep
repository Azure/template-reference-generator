param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource sqlRoleDefinition 'Microsoft.DocumentDB/databaseAccounts/sqlRoleDefinitions@2021-10-15' existing = {
  name: '00000000-0000-0000-0000-000000000001'
  parent: databaseAccount
}

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    enableFreeTier: false
    databaseAccountOfferType: 'Standard'
    disableKeyBasedMetadataWriteAccess: false
    enableMultipleWriteLocations: false
    isVirtualNetworkFilterEnabled: false
    networkAclBypassResourceIds: []
    virtualNetworkRules: []
    capabilities: []
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
    }
    defaultIdentity: 'FirstPartyIdentity'
    disableLocalAuth: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    networkAclBypass: 'None'
    publicNetworkAccess: 'Enabled'
    enableAutomaticFailover: false
    ipRules: []
    enableAnalyticalStorage: false
  }
}

resource sqlRoleAssignment 'Microsoft.DocumentDB/databaseAccounts/sqlRoleAssignments@2021-10-15' = {
  name: 'ff419bf7-f8ca-ef51-00d2-3576700c341b'
  parent: databaseAccount
  properties: {
    roleDefinitionId: sqlRoleDefinition.id
    scope: databaseAccount.id
    principalId: cluster.identity.principalId
  }
}

resource cluster 'Microsoft.Kusto/clusters@2023-05-02' = {
  name: resourceName
  location: location
  sku: {
    tier: 'Basic'
    capacity: 1
    name: 'Dev(No SLA)_Standard_D11_v2'
  }
  properties: {
    enablePurge: false
    restrictOutboundNetworkAccess: 'Disabled'
    enableDiskEncryption: false
    enableDoubleEncryption: false
    enableStreamingIngest: false
    engineType: 'V2'
    publicIPType: 'IPv4'
    publicNetworkAccess: 'Enabled'
    trustedExternalTenants: []
    enableAutoStop: true
  }
}

resource database 'Microsoft.Kusto/clusters/databases@2023-05-02' = {
  name: resourceName
  location: location
  parent: cluster
  kind: 'ReadWrite'
  properties: {}
}
