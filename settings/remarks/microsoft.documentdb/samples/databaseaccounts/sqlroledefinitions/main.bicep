param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    consistencyPolicy: {
      defaultConsistencyLevel: 'Strong'
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
    }
    disableKeyBasedMetadataWriteAccess: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    databaseAccountOfferType: 'Standard'
    enableFreeTier: false
    enableMultipleWriteLocations: false
    ipRules: []
    isVirtualNetworkFilterEnabled: false
    networkAclBypass: 'None'
    networkAclBypassResourceIds: []
    publicNetworkAccess: 'Enabled'
    capabilities: []
    disableLocalAuth: false
    enableAnalyticalStorage: false
    virtualNetworkRules: []
    defaultIdentity: 'FirstPartyIdentity'
    enableAutomaticFailover: false
  }
}

resource sqlRoleDefinition 'Microsoft.DocumentDB/databaseAccounts/sqlRoleDefinitions@2021-10-15' = {
  name: 'c3ce1661-d0b9-3476-0a7c-2654ce2f3055'
  parent: databaseAccount
  properties: {
    assignableScopes: [
      databaseAccount.id
    ]
    permissions: [
      {
        dataActions: [
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/read'
        ]
      }
    ]
    roleName: resourceName
    type: 'CustomRole'
  }
}
