targetScope = 'subscription'

param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: resourceName
  location: location
}

resource logProfile 'Microsoft.Insights/logProfiles@2016-03-01' = {
  name: resourceName
  properties: {
    categories: [
      'Action'
    ]
    locations: [
      'westeurope'
      'westeurope'
    ]
    retentionPolicy: {
      enabled: true
      days: 7
    }
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
