param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    defaultIdentity: 'FirstPartyIdentity'
    disableKeyBasedMetadataWriteAccess: false
    disableLocalAuth: false
    enableAutomaticFailover: false
    isVirtualNetworkFilterEnabled: false
    networkAclBypass: 'None'
    publicNetworkAccess: 'Enabled'
    virtualNetworkRules: []
    consistencyPolicy: {
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
      defaultConsistencyLevel: 'Strong'
    }
    enableAnalyticalStorage: false
    enableFreeTier: false
    enableMultipleWriteLocations: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    capabilities: []
    databaseAccountOfferType: 'Standard'
    ipRules: []
    networkAclBypassResourceIds: []
  }
}

resource sqlRoleDefinition 'Microsoft.DocumentDB/databaseAccounts/sqlRoleDefinitions@2021-10-15' = {
  name: 'c3ce1661-d0b9-3476-0a7c-2654ce2f3055'
  parent: databaseAccount
  properties: {
    permissions: [
      {
        dataActions: [
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/read'
        ]
      }
    ]
    roleName: resourceName
    type: 'CustomRole'
    assignableScopes: [
      databaseAccount.id
    ]
  }
}
