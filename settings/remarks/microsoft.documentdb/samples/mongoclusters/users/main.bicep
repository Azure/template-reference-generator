param resourceName string = 'acctest0001'
param location string = 'westus3'

resource mongoClusterSSDv2 'Microsoft.DocumentDB/mongoClusters@2025-09-01' = {
  name: '${resourceName}-ssdv2'
  location: location
  properties: {
    authConfig: {
      allowedModes: [
        'MicrosoftEntraID'
      ]
    }
    compute: {
      tier: 'M30'
    }
    highAvailability: {
      targetMode: 'Disabled'
    }
    publicNetworkAccess: 'Disabled'
    serverVersion: '6.0'
    sharding: {
      shardCount: 1
    }
    storage: {
      sizeGb: 64
      type: 'PremiumSSDv2'
    }
  }
}

resource mongouserEntraserviceprincipal 'Microsoft.DocumentDB/mongoClusters/users@2025-09-01' = {
  name: 'azapi_resource.userAssignedIdentity.output.properties.principalId'
  parent: mongoClusterSSDv2
  properties: {
    identityProvider: {
      properties: {
        principalType: 'ServicePrincipal'
      }
      type: 'MicrosoftEntraID'
    }
    roles: [
      {
        db: 'admin'
        role: 'root'
      }
    ]
  }
}

resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: resourceName
  location: location
}
