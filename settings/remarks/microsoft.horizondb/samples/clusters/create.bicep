@description('The location for the cluster')
param location string = 'eastus'
@description('The name for the cluster')
param clusterName string
@description('The tags for the cluster')
param tags object = {
  env: 'dev'
}
@description('The create mode for cluster')
param createMode string = 'Create'
@description('The major version of server')
param version int = 17
@description('The administrator login name for cluster')
param administratorLogin string
@secure()
@description('The administrator login password for cluster')
param administratorLoginPassword string
@description('The number of vCores for each replica of the cluster')
param vCores int = 4
@description('The number of replicas for the cluster, including the primary replica, which is the only one in which writes are allowed. The other replicas are read-only.')
param replicaCount int = 2
@description('The name of the SKU for cluster')
param zonePlacementPolicy string = 'BestEffort'
resource flexibleServer 'Microsoft.HorizonDB/clusters@2026-01-20-preview' = {
  name: clusterName
  location: location
  tags: tags
  properties: {
    createMode: createMode
    version: version
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    vCores: vCores
    replicaCount: replicaCount
    zonePlacementPolicy: zonePlacementPolicy
  }
}
