param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource profile 'Microsoft.Cdn/profiles@2021-06-01' = {
  name: resourceName
  location: 'global'
  sku: {
    name: 'Standard_AzureFrontDoor'
  }
  properties: {
    originResponseTimeoutSeconds: 120
  }
}

resource originGroup 'Microsoft.Cdn/profiles/originGroups@2021-06-01' = {
  name: resourceName
  parent: profile
  properties: {
    loadBalancingSettings: {
      sampleSize: 16
      successfulSamplesRequired: 3
      additionalLatencyInMilliseconds: 0
    }
    sessionAffinityState: 'Enabled'
    trafficRestorationTimeToHealedOrNewEndpointsInMinutes: 10
  }
}
