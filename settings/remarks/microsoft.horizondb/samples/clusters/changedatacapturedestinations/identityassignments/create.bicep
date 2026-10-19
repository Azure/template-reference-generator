@description('The name of the HorizonDB cluster')
param clusterName string = 'example-cluster'
@description('The name of the change data capture destination')
param destinationName string = 'fabric-mirroring'
@description('The name of the identity assignment')
param assignmentName string = 'fabric-writer'

resource horizonDbResource 'Microsoft.HorizonDb/clusters/changeDataCaptureDestinations/identityAssignments@2026-10-01-preview' = {
  name: '${clusterName}/${destinationName}/${assignmentName}'
  properties: {
    identityResourceId: '/subscriptions/ffffffff-ffff-ffff-ffff-ffffffffffff/resourceGroups/identity-resource-group/providers/Microsoft.ManagedIdentity/userAssignedIdentities/fabric-writer'
  }
}
