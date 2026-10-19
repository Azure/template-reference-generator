@description('The name of the HorizonDB cluster')
param clusterName string = 'example-cluster'

resource horizonDbResource 'Microsoft.HorizonDb/clusters/authentications@2026-10-01-preview' = {
  name: '${clusterName}/microsoftEntra'
  properties: {
    state: 'Enabled'
  }
}
