@description('The name of the HorizonDB cluster')
param clusterName string = 'restored-cluster'

resource horizonDbResource 'Microsoft.HorizonDb/clusters@2026-10-01-preview' = {
  name: clusterName
  location: 'eastus2'
  properties: {
    creationMode: 'PointInTimeRestore'
    pointInTimeUtc: '2026-07-27T12:00:00Z'
    creationSourceClusterResourceId: '/subscriptions/ffffffff-ffff-ffff-ffff-ffffffffffff/resourceGroups/example-resource-group/providers/Microsoft.HorizonDb/clusters/source-cluster'
    network: {
      publicAccess: 'Disabled'
    }
    backup: {
      geoRedundancy: 'Enabled'
      retentionDays: 14
    }
  }
}
