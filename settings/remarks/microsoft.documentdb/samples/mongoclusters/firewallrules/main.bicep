param resourceName string = 'acctest0001'
param location string = 'westus3'

resource mongoCluster 'Microsoft.DocumentDB/mongoClusters@2025-09-01' = {
  name: resourceName
  location: location
  properties: {
    authConfig: {
      allowedModes: [
        'MicrosoftEntraID'
      ]
    }
    compute: {
      tier: 'M40'
    }
    highAvailability: {
      targetMode: 'Disabled'
    }
    previewFeatures: [
      'ShardRebalancer'
    ]
    publicNetworkAccess: 'Enabled'
    serverVersion: '5.0'
    sharding: {
      shardCount: 1
    }
    storage: {
      sizeGb: 32
    }
  }
}

resource firewallRule 'Microsoft.DocumentDB/mongoClusters/firewallRules@2025-09-01' = {
  parent: mongoCluster
  name: resourceName
  properties: {
    endIpAddress: '0.0.0.0'
    startIpAddress: '0.0.0.0'
  }
}
