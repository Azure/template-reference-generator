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

resource afdEndpoint 'Microsoft.Cdn/profiles/afdEndpoints@2021-06-01' = {
  name: resourceName
  location: 'global'
  parent: profile
  properties: {
    enabledState: 'Enabled'
  }
}

resource originGroup 'Microsoft.Cdn/profiles/originGroups@2021-06-01' = {
  name: resourceName
  parent: profile
  properties: {
    trafficRestorationTimeToHealedOrNewEndpointsInMinutes: 10
    loadBalancingSettings: {
      sampleSize: 16
      successfulSamplesRequired: 3
      additionalLatencyInMilliseconds: 0
    }
    sessionAffinityState: 'Enabled'
  }
}

resource origin 'Microsoft.Cdn/profiles/originGroups/origins@2021-06-01' = {
  name: resourceName
  parent: originGroup
  properties: {
    enabledState: 'Enabled'
    enforceCertificateNameCheck: false
    httpPort: 80
    httpsPort: 443
    weight: 1
    hostName: 'contoso.com'
    originHostHeader: 'www.contoso.com'
    priority: 1
  }
}

resource route 'Microsoft.Cdn/profiles/afdEndpoints/routes@2021-06-01' = {
  name: resourceName
  parent: afdEndpoint
  properties: {
    forwardingProtocol: 'MatchRequest'
    httpsRedirect: 'Enabled'
    linkToDefaultDomain: 'Enabled'
    originGroup: {
      id: originGroup.id
    }
    patternsToMatch: [
      '/*'
    ]
    supportedProtocols: [
      'Https'
      'Http'
    ]
    enabledState: 'Enabled'
  }
}
