param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    defaultIdentity: 'FirstPartyIdentity'
    disableKeyBasedMetadataWriteAccess: false
    enableFreeTier: false
    enableMultipleWriteLocations: false
    isVirtualNetworkFilterEnabled: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    disableLocalAuth: false
    enableAnalyticalStorage: false
    ipRules: []
    databaseAccountOfferType: 'Standard'
    enableAutomaticFailover: false
    networkAclBypassResourceIds: []
    publicNetworkAccess: 'Enabled'
    virtualNetworkRules: []
    networkAclBypass: 'None'
    capabilities: []
    consistencyPolicy: {
      defaultConsistencyLevel: 'BoundedStaleness'
      maxIntervalInSeconds: 10
      maxStalenessPrefix: 200
    }
  }
}
