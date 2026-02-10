param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    enableFreeTier: false
    enableMultipleWriteLocations: false
    isVirtualNetworkFilterEnabled: false
    capabilities: []
    defaultIdentity: 'FirstPartyIdentity'
    enableAnalyticalStorage: false
    networkAclBypass: 'None'
    virtualNetworkRules: []
    databaseAccountOfferType: 'Standard'
    enableAutomaticFailover: false
    consistencyPolicy: {
      defaultConsistencyLevel: 'BoundedStaleness'
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
    }
    disableLocalAuth: false
    ipRules: []
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    networkAclBypassResourceIds: []
    publicNetworkAccess: 'Enabled'
    disableKeyBasedMetadataWriteAccess: false
  }
}

resource service 'Microsoft.DocumentDB/databaseAccounts/services@2022-05-15' = {
  name: 'SqlDedicatedGateway'
  parent: databaseAccount
  properties: {
    instanceCount: 1
    instanceSize: 'Cosmos.D4s'
    serviceType: 'SqlDedicatedGateway'
  }
}
