param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    disableKeyBasedMetadataWriteAccess: false
    disableLocalAuth: false
    enableAutomaticFailover: false
    locations: [
      {
        isZoneRedundant: false
        locationName: 'West Europe'
        failoverPriority: 0
      }
    ]
    networkAclBypass: 'None'
    databaseAccountOfferType: 'Standard'
    enableAnalyticalStorage: false
    defaultIdentity: 'FirstPartyIdentity'
    isVirtualNetworkFilterEnabled: false
    networkAclBypassResourceIds: []
    virtualNetworkRules: []
    capabilities: []
    enableFreeTier: false
    enableMultipleWriteLocations: false
    ipRules: []
    publicNetworkAccess: 'Enabled'
    consistencyPolicy: {
      defaultConsistencyLevel: 'BoundedStaleness'
      maxIntervalInSeconds: 10
      maxStalenessPrefix: 200
    }
  }
}
