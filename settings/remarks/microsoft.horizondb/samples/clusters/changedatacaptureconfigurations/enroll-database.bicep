@description('The name of the HorizonDB cluster')
param clusterName string = 'example-cluster'
@description('The name of the change data capture configuration')
param configurationName string = 'sales-database'

resource horizonDbResource 'Microsoft.HorizonDb/clusters/changeDataCaptureConfigurations@2026-10-01-preview' = {
  name: '${clusterName}/${configurationName}'
  properties: {
    databaseName: 'sales'
    usageProfile: 'Mirroring'
    destinationResourceId: '/subscriptions/ffffffff-ffff-ffff-ffff-ffffffffffff/resourceGroups/example-resource-group/providers/Microsoft.HorizonDb/clusters/example-cluster/changeDataCaptureDestinations/fabric-mirroring'
    desiredState: 'Enabled'
  }
}
