param location string = 'westeurope'
param resourceName string = 'acctest0001'

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
      additionalLatencyInMilliseconds: 0
      sampleSize: 16
      successfulSamplesRequired: 3
    }
    sessionAffinityState: 'Enabled'
    trafficRestorationTimeToHealedOrNewEndpointsInMinutes: 10
  }
}

resource origin 'Microsoft.Cdn/profiles/originGroups/origins@2021-06-01' = {
  name: resourceName
  parent: originGroup
  properties: {
    enabledState: 'Enabled'
    enforceCertificateNameCheck: false
    hostName: 'contoso.com'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'www.contoso.com'
    priority: 1
    weight: 1
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

resource route 'Microsoft.Cdn/profiles/afdEndpoints/routes@2021-06-01' = {
  name: resourceName
  parent: afdEndpoint
  properties: {
    enabledState: 'Enabled'
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
  }
}
