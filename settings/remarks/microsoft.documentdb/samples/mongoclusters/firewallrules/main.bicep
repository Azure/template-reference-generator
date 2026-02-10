param resourceName string = 'acctest0001'
param location string = 'westus3'

resource mongoCluster 'Microsoft.DocumentDB/mongoClusters@2025-09-01' = {
  name: resourceName
  location: location
  properties: {
    compute: {
      tier: 'M40'
    }
    previewFeatures: [
      'ShardRebalancer'
    ]
    publicNetworkAccess: 'Enabled'
    sharding: {
      shardCount: 1
    }
    authConfig: {
      allowedModes: [
        'MicrosoftEntraID'
      ]
    }
    highAvailability: {
      targetMode: 'Disabled'
    }
    serverVersion: '5.0'
    storage: {
      sizeGb: 32
    }
  }
}

resource firewallRule 'Microsoft.DocumentDB/mongoClusters/firewallRules@2025-09-01' = {
  name: resourceName
  parent: mongoCluster
  properties: {
    endIpAddress: '0.0.0.0'
    startIpAddress: '0.0.0.0'
  }
}
