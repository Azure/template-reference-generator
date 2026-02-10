param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    enableFreeTier: false
    enableMultipleWriteLocations: false
    publicNetworkAccess: 'Enabled'
    defaultIdentity: 'FirstPartyIdentity'
    enableAutomaticFailover: false
    networkAclBypassResourceIds: []
    ipRules: []
    locations: [
      {
        isZoneRedundant: false
        locationName: 'West Europe'
        failoverPriority: 0
      }
    ]
    networkAclBypass: 'None'
    capabilities: []
    consistencyPolicy: {
      defaultConsistencyLevel: 'BoundedStaleness'
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
    }
    databaseAccountOfferType: 'Standard'
    enableAnalyticalStorage: false
    isVirtualNetworkFilterEnabled: false
    virtualNetworkRules: []
    disableKeyBasedMetadataWriteAccess: false
    disableLocalAuth: false
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
