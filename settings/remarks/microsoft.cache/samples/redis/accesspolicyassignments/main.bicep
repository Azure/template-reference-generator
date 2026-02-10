param resourceName string = 'acctest0001'
param location string = 'eastus'

resource redis 'Microsoft.Cache/redis@2023-04-01' = {
  name: resourceName
  location: location
  properties: {
    enableNonSslPort: true
    minimumTlsVersion: '1.2'
    sku: {
      name: 'Standard'
      capacity: 2
      family: 'C'
    }
  }
}

resource accessPolicyAssignment 'Microsoft.Cache/redis/accessPolicyAssignments@2024-03-01' = {
  name: resourceName
  parent: redis
  properties: {
    accessPolicyName: 'Data Contributor'
    objectId: deployer().objectId
    objectIdAlias: 'ServicePrincipal'
  }
}
