param resourceName string = 'acctest0001'
param location string = 'westus'

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: resourceName
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
  }
}

resource solution 'Microsoft.OperationsManagement/solutions@2015-11-01-preview' = {
  name: 'ContainerInsights(${resourceName})'
  location: location
  properties: {
    workspaceResourceId: workspace.id
  }
}
