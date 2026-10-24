@description('The name of the HorizonDB cluster')
param clusterName string = 'example-cluster'
@description('The name of the change data capture destination')
param destinationName string = 'fabric-mirroring'

resource horizonDbResource 'Microsoft.HorizonDb/clusters/changeDataCaptureDestinations@2026-10-01-preview' = {
  name: '${clusterName}/${destinationName}'
  properties: {
    desiredState: 'Disabled'
  }
}
