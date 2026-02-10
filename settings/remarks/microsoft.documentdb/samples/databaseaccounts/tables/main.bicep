param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    databaseAccountOfferType: 'Standard'
    enableAutomaticFailover: false
    enableFreeTier: false
    capabilities: [
      {
        name: 'EnableTable'
      }
    ]
    consistencyPolicy: {
      maxStalenessPrefix: 100
      defaultConsistencyLevel: 'Strong'
      maxIntervalInSeconds: 5
    }
    disableLocalAuth: false
    ipRules: []
    virtualNetworkRules: []
    disableKeyBasedMetadataWriteAccess: false
    enableAnalyticalStorage: false
    isVirtualNetworkFilterEnabled: false
    networkAclBypassResourceIds: []
    publicNetworkAccess: 'Enabled'
    defaultIdentity: 'FirstPartyIdentity'
    enableMultipleWriteLocations: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    networkAclBypass: 'None'
  }
}

resource table 'Microsoft.DocumentDB/databaseAccounts/tables@2021-10-15' = {
  name: resourceName
  parent: databaseAccount
  properties: {
    options: {}
    resource: {
      id: '${resourceName}'
    }
  }
}
