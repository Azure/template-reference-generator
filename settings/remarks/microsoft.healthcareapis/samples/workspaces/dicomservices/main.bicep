param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource workspace 'Microsoft.HealthcareApis/workspaces@2022-12-01' = {
  name: resourceName
  location: location
}

resource dicomService 'Microsoft.HealthcareApis/workspaces/dicomServices@2022-12-01' = {
  parent: workspace
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}
