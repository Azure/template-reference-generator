@description('The name of the HorizonDB cluster')
param clusterName string = 'minimum-defaults'

resource horizonDbResource 'Microsoft.HorizonDb/clusters@2026-10-01-preview' = {
  name: clusterName
  location: 'eastus2'
  properties: {
    postgreSqlVersion: '18'
    backup: {
      geoRedundancy: 'Disabled'
    }
  }
}
