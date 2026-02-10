param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    disableKeyBasedMetadataWriteAccess: false
    disableLocalAuth: false
    isVirtualNetworkFilterEnabled: false
    networkAclBypassResourceIds: []
    capabilities: []
    consistencyPolicy: {
      defaultConsistencyLevel: 'BoundedStaleness'
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
    }
    publicNetworkAccess: 'Enabled'
    databaseAccountOfferType: 'Standard'
    enableAnalyticalStorage: false
    enableMultipleWriteLocations: false
    ipRules: []
    virtualNetworkRules: []
    defaultIdentity: 'FirstPartyIdentity'
    enableAutomaticFailover: false
    enableFreeTier: false
    locations: [
      {
        locationName: 'West Europe'
        failoverPriority: 0
        isZoneRedundant: false
      }
    ]
    networkAclBypass: 'None'
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
