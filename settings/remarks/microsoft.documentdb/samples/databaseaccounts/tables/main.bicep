param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    publicNetworkAccess: 'Enabled'
    consistencyPolicy: {
      defaultConsistencyLevel: 'Strong'
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
    }
    defaultIdentity: 'FirstPartyIdentity'
    disableLocalAuth: false
    enableAnalyticalStorage: false
    enableAutomaticFailover: false
    databaseAccountOfferType: 'Standard'
    ipRules: []
    networkAclBypass: 'None'
    virtualNetworkRules: []
    capabilities: [
      {
        name: 'EnableTable'
      }
    ]
    disableKeyBasedMetadataWriteAccess: false
    enableMultipleWriteLocations: false
    isVirtualNetworkFilterEnabled: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    networkAclBypassResourceIds: []
    enableFreeTier: false
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
