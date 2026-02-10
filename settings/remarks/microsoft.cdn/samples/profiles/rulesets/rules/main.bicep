param resourceName string = 'acctest0001'
param location string = 'westus'
param cdnLocation string = 'global'

resource profile 'Microsoft.Cdn/profiles@2024-09-01' = {
  name: '${resourceName}-profile'
  location: cdnLocation
  sku: {
    name: 'Standard_AzureFrontDoor'
  }
  properties: {
    originResponseTimeoutSeconds: 120
  }
}

resource originGroup 'Microsoft.Cdn/profiles/originGroups@2024-09-01' = {
  name: '${resourceName}-origingroup'
  parent: profile
  properties: {
    sessionAffinityState: 'Enabled'
    trafficRestorationTimeToHealedOrNewEndpointsInMinutes: 10
    loadBalancingSettings: {
      additionalLatencyInMilliseconds: 0
      sampleSize: 16
      successfulSamplesRequired: 3
    }
  }
}

resource ruleSet 'Microsoft.Cdn/profiles/ruleSets@2024-09-01' = {
  name: 'ruleSet${substring(resourceName, (length(resourceName) - 4), 3)}'
  parent: profile
}

resource origin 'Microsoft.Cdn/profiles/originGroups/origins@2024-09-01' = {
  name: '${resourceName}-origin'
  parent: originGroup
  properties: {
    priority: 1
    weight: 1
    enabledState: 'Enabled'
    enforceCertificateNameCheck: false
    hostName: 'contoso.com'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'www.contoso.com'
  }
}

resource rule 'Microsoft.Cdn/profiles/ruleSets/rules@2024-09-01' = {
  name: 'rule${substring(resourceName, (length(resourceName) - 4), 3)}'
  parent: ruleSet
  properties: {
    order: 1
    actions: [
      {
        name: 'RouteConfigurationOverride'
        parameters: {
          cacheConfiguration: {
            queryParameters: 'clientIp={client_ip}'
            queryStringCachingBehavior: 'IgnoreSpecifiedQueryStrings'
            cacheBehavior: 'OverrideIfOriginMissing'
            cacheDuration: '23:59:59'
            isCompressionEnabled: 'Disabled'
          }
          originGroupOverride: {
            forwardingProtocol: 'HttpsOnly'
            originGroup: {
              id: originGroup.id
            }
          }
          typeName: 'DeliveryRuleRouteConfigurationOverrideActionParameters'
        }
      }
    ]
    conditions: []
    matchProcessingBehavior: 'Continue'
  }
}
