param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource sqlRoleDefinition 'Microsoft.DocumentDB/databaseAccounts/sqlRoleDefinitions@2021-10-15' existing = {
  parent: databaseAccount
  name: '00000000-0000-0000-0000-000000000001'
}

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

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    capabilities: []
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
    }
    databaseAccountOfferType: 'Standard'
    defaultIdentity: 'FirstPartyIdentity'
    disableKeyBasedMetadataWriteAccess: false
    disableLocalAuth: false
    enableAnalyticalStorage: false
    enableAutomaticFailover: false
    enableFreeTier: false
    enableMultipleWriteLocations: false
    ipRules: []
    isVirtualNetworkFilterEnabled: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    networkAclBypass: 'None'
    networkAclBypassResourceIds: []
    publicNetworkAccess: 'Enabled'
    virtualNetworkRules: []
  }
}

resource database 'Microsoft.Kusto/clusters/databases@2023-05-02' = {
  parent: cluster
  name: resourceName
  location: location
  kind: 'ReadWrite'
  properties: {}
}

resource sqlRoleAssignment 'Microsoft.DocumentDB/databaseAccounts/sqlRoleAssignments@2021-10-15' = {
  parent: databaseAccount
  name: 'ff419bf7-f8ca-ef51-00d2-3576700c341b'
  properties: {
    principalId: cluster.properties.identity.principalId
    roleDefinitionId: sqlRoleDefinition.id
    scope: databaseAccount.id
  }
}
