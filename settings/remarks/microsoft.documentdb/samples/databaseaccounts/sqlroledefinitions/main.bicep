param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    disableLocalAuth: false
    enableMultipleWriteLocations: false
    networkAclBypass: 'None'
    networkAclBypassResourceIds: []
    publicNetworkAccess: 'Enabled'
    disableKeyBasedMetadataWriteAccess: false
    enableAutomaticFailover: false
    ipRules: []
    isVirtualNetworkFilterEnabled: false
    consistencyPolicy: {
      defaultConsistencyLevel: 'Strong'
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
    }
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    capabilities: []
    databaseAccountOfferType: 'Standard'
    defaultIdentity: 'FirstPartyIdentity'
    enableAnalyticalStorage: false
    enableFreeTier: false
    virtualNetworkRules: []
  }
}

resource sqlRoleDefinition 'Microsoft.DocumentDB/databaseAccounts/sqlRoleDefinitions@2021-10-15' = {
  name: 'c3ce1661-d0b9-3476-0a7c-2654ce2f3055'
  parent: databaseAccount
  properties: {
    type: 'CustomRole'
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
  }
}
