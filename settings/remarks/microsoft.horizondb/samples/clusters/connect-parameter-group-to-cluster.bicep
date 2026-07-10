@description('The location for the cluster')
param location string = 'eastus'
@description('The name for the cluster')
param clusterName string
@description('The create mode for cluster')
param createMode string = 'Update'
@description('The identifier of the parameter group to connect to the cluster')
param parameterGroupId string
resource flexibleServer 'Microsoft.HorizonDB/clusters@2026-01-20-preview' = {
  name: clusterName
  location: location
  properties: {
    createMode: createMode
    parameterGroup: {
      id: parameterGroupId
    }
  }
}
