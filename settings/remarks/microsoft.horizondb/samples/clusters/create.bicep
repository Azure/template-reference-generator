@description('The name of the HorizonDB cluster')
param clusterName string = 'example-cluster'

resource horizonDbResource 'Microsoft.HorizonDb/clusters@2026-10-01-preview' = {
  name: clusterName
  location: 'eastus2'
  tags: {
    environment: 'production'
  }
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '/subscriptions/ffffffff-ffff-ffff-ffff-ffffffffffff/resourceGroups/identity-resource-group/providers/Microsoft.ManagedIdentity/userAssignedIdentities/fabric-writer': {
      }
    }
  }
  properties: {
    postgreSqlVersion: '17'
    network: {
      publicAccess: 'Enabled'
    }
    backup: {
      geoRedundancy: 'Enabled'
      retentionDays: 14
    }
  }
}
