@description('The name of the HorizonDB cluster')
param clusterName string = 'example-cluster'

resource horizonDbResource 'Microsoft.HorizonDb/clusters@2026-10-01-preview' = {
  name: clusterName
  tags: {
    environment: 'production'
    team: 'data-platform'
  }
  properties: {
    network: {
      publicAccess: 'Disabled'
    }
    backup: {
      retentionDays: 21
    }
  }
}
