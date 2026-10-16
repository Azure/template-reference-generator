@description('The name of the HorizonDB cluster')
param clusterName string = 'example-cluster'

resource horizonDbResource 'Microsoft.HorizonDb/clusters/changeDataCapture@2026-10-01-preview' = {
  name: '${clusterName}/default'
  properties: {
    desiredState: 'Enabled'
    autoUpgradeExtension: true
  }
}
