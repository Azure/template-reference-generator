param resourceName string = 'acctest0001'
param location string = 'westus3'

resource mongoCluster 'Microsoft.DocumentDB/mongoClusters@2025-09-01' = {
  name: resourceName
  location: location
  properties: {
    compute: {
      tier: 'M40'
    }
    highAvailability: {
      targetMode: 'Disabled'
    }
    serverVersion: '5.0'
    sharding: {
      shardCount: 1
    }
    storage: {
      sizeGb: 32
    }
    authConfig: {
      allowedModes: [
        'MicrosoftEntraID'
      ]
    }
    previewFeatures: [
      'ShardRebalancer'
    ]
    publicNetworkAccess: 'Enabled'
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
