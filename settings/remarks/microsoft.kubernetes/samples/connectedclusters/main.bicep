param resourceName string = 'acctest0001'
param location string = 'westus'

resource connectedCluster 'Microsoft.Kubernetes/connectedClusters@2024-01-01' = {
  name: '${resourceName}-cc'
  location: location
  kind: 'ProvisionedCluster'
  properties: {
    agentPublicKeyCertificate: ''
    arcAgentProfile: {
      agentAutoUpgrade: 'Enabled'
    }
  }
}
