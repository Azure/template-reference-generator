@description('The location for the cluster')
param location string = 'eastus'
@description('The name for the cluster')
param clusterName string
@description('The create mode for cluster')
param createMode string = 'Update'
@description('The number of vCores for each replica of the cluster')
param vCores int = 8
resource flexibleServer 'Microsoft.HorizonDB/clusters@2026-01-20-preview' = {
  name: clusterName
  location: location
  properties: {
    createMode: createMode
    vCores: vCores
  }
}
