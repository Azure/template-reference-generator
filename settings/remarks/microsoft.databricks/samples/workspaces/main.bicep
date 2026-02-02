param resourceName string = 'acctest0001'
param location string = 'eastus2'

resource workspace 'Microsoft.Databricks/workspaces@2023-02-01' = {
  name: resourceName
  location: location
  properties: {
    managedResourceGroupId: resourceId('Microsoft.Resources/resourceGroups', 'databricks-rg-${resourceName}')
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
  sku: {
    name: 'premium'
  }
}
