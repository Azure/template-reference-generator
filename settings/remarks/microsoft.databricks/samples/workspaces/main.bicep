param resourceName string = 'acctest0001'
param location string = 'eastus2'

resource workspace 'Microsoft.Databricks/workspaces@2023-02-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'premium'
  }
  properties: {
    managedResourceGroupId: resourceGroup().id
    parameters: {
      prepareEncryption: {
        value: true
      }
      requireInfrastructureEncryption: {
        value: true
      }
    }
    publicNetworkAccess: 'Enabled'
  }
}
