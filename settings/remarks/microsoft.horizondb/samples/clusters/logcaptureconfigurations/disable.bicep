@description('The name of the HorizonDB cluster')
param clusterName string = 'example-cluster'
@description('The name of the log capture configuration')
param logCaptureConfigurationName string = 'PostgreSqlServer'

resource horizonDbResource 'Microsoft.HorizonDb/clusters/logCaptureConfigurations@2026-10-01-preview' = {
  name: '${clusterName}/${logCaptureConfigurationName}'
  properties: {
    state: 'Disabled'
  }
}
