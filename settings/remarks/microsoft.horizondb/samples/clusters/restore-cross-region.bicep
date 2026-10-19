@description('The name of the HorizonDB cluster')
param clusterName string = 'cross-region-restored-cluster'

resource horizonDbResource 'Microsoft.HorizonDb/clusters@2026-10-01-preview' = {
  name: clusterName
  location: 'westus2'
  properties: {
    creationMode: 'PointInTimeRestore'
    pointInTimeUtc: '2026-07-27T12:00:00Z'
    creationSourceClusterResourceId: '/subscriptions/ffffffff-ffff-ffff-ffff-ffffffffffff/resourceGroups/example-resource-group/providers/Microsoft.HorizonDb/clusters/source-cluster'
    creationSourceClusterLocation: 'eastus2'
    network: {
      publicAccess: 'Disabled'
    }
    backup: {
      geoRedundancy: 'Enabled'
      retentionDays: 14
    }
  }
}
