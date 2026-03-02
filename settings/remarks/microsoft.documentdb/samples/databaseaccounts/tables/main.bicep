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
    defaultIdentity: 'FirstPartyIdentity'
    publicNetworkAccess: 'Enabled'
    virtualNetworkRules: []
    databaseAccountOfferType: 'Standard'
    enableAnalyticalStorage: false
    enableMultipleWriteLocations: false
    ipRules: []
    networkAclBypass: 'None'
    networkAclBypassResourceIds: []
    disableKeyBasedMetadataWriteAccess: false
    disableLocalAuth: false
    enableAutomaticFailover: false
    isVirtualNetworkFilterEnabled: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    capabilities: [
      {
        name: 'EnableTable'
      }
    ]
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
