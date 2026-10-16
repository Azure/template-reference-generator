@description('The name of the HorizonDB cluster')
param clusterName string = 'example-cluster'
@description('The name of the HorizonDB pool')
param poolName string = 'example-pool-01'

resource horizonDbResource 'Microsoft.HorizonDb/clusters/pools@2026-10-01-preview' = {
  name: '${clusterName}/${poolName}'
  properties: {
    parameterGroup: {
      parameterGroupResourceId: '/subscriptions/ffffffff-ffff-ffff-ffff-ffffffffffff/providers/Microsoft.HorizonDb/locations/eastus2/parameterGroups/default-postgresql-17-provisioned'
      applyMethod: 'Immediate'
    }
  }
}
