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
    trafficRestorationTimeToHealedOrNewEndpointsInMinutes: 10
    loadBalancingSettings: {
      additionalLatencyInMilliseconds: 0
      sampleSize: 16
      successfulSamplesRequired: 3
    }
    sessionAffinityState: 'Enabled'
  }
}

resource origin 'Microsoft.Cdn/profiles/originGroups/origins@2021-06-01' = {
  name: resourceName
  parent: originGroup
  properties: {
    httpsPort: 443
    originHostHeader: 'www.contoso.com'
    priority: 1
    enforceCertificateNameCheck: false
    hostName: 'contoso.com'
    weight: 1
    enabledState: 'Enabled'
    httpPort: 80
  }
}
