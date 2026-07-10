@description('The name for the cluster')
param clusterName string
@description('The name for the pool')
param poolName string = 'DefaultPool'
@description('The name for the replica')
param replicaName string
@description('The role for the replica')
param role string = 'Read'
@description('The availability zone for the replica')
param availabilityZone string = '1'
resource replica 'Microsoft.HorizonDB/clusters/pools/replicas@2026-01-20-preview' = {
  name: '${clusterName}/${poolName}/${replicaName}'
  properties: {
    role: role
    availabilityZone: availabilityZone
  }
}
