param resourceName string = 'acctest0001'
param cdnLocation string = 'global'

resource profile 'Microsoft.Cdn/profiles@2024-09-01' = {
  name: '${resourceName}-profile'
  properties: {
    originResponseTimeoutSeconds: 120
  }
  sku: {
    name: 'Standard_AzureFrontDoor'
  }
}

resource originGroup 'Microsoft.Cdn/profiles/originGroups@2024-09-01' = {
  parent: profile
  name: '${resourceName}-origingroup'
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

resource ruleSet 'Microsoft.Cdn/profiles/ruleSets@2024-09-01' = {
  parent: profile
  name: 'ruleSet${substring(resourceName, length(resourceName) - 4, 4)}'
}

resource origin 'Microsoft.Cdn/profiles/originGroups/origins@2024-09-01' = {
  parent: originGroup
  name: '${resourceName}-origin'
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

resource rule 'Microsoft.Cdn/profiles/ruleSets/rules@2024-09-01' = {
  parent: ruleSet
  name: 'rule${substring(resourceName, length(resourceName) - 4, 4)}'
  properties: {
    actions: [
      {
        name: 'RouteConfigurationOverride'
        parameters: {
          cacheConfiguration: {
            cacheBehavior: 'OverrideIfOriginMissing'
            cacheDuration: '23:59:59'
            isCompressionEnabled: 'Disabled'
            queryParameters: 'clientIp={client_ip}'
            queryStringCachingBehavior: 'IgnoreSpecifiedQueryStrings'
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
    order: 1
  }
}
