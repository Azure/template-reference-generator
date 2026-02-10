targetScope = 'subscription'

param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: resourceName
  location: location
}

resource logProfile 'Microsoft.Insights/logProfiles@2016-03-01' = {
  name: resourceName
  properties: {
    retentionPolicy: {
      days: 7
      enabled: true
    }
    categories: [
      'Action'
    ]
    locations: [
      'westeurope'
      'westeurope'
    ]
  }
}

module module1 'main-rg-module.bicep' = {
  name: 'deploy-rg-resources'
  scope: resourceGroup
  params: {
    resourceName: resourceName
    location: location
  }
}
