@description('The name of the HorizonDB cluster')
param clusterName string = 'example-cluster'
@description('The name of the HorizonDB pool')
param poolName string = 'example-pool-01'

resource horizonDbResource 'Microsoft.HorizonDb/clusters/pools@2026-10-01-preview' = {
  name: '${clusterName}/${poolName}'
  properties: {
    highAvailability: {
      mode: 'ZoneRedundant'
    }
  }
}
