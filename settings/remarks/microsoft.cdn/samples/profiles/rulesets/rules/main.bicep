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
    trafficRestorationTimeToHealedOrNewEndpointsInMinutes: 10
    loadBalancingSettings: {
      additionalLatencyInMilliseconds: 0
      sampleSize: 16
      successfulSamplesRequired: 3
    }
    sessionAffinityState: 'Enabled'
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
    enforceCertificateNameCheck: false
    httpsPort: 443
    weight: 1
    enabledState: 'Enabled'
    hostName: 'contoso.com'
    httpPort: 80
    originHostHeader: 'www.contoso.com'
    priority: 1
  }
}

resource rule 'Microsoft.Cdn/profiles/ruleSets/rules@2024-09-01' = {
  name: 'rule${substring(resourceName, (length(resourceName) - 4), 3)}'
  parent: ruleSet
  properties: {
    actions: [
      {
        name: 'RouteConfigurationOverride'
        parameters: {
          originGroupOverride: {
            forwardingProtocol: 'HttpsOnly'
            originGroup: {
              id: originGroup.id
            }
          }
          typeName: 'DeliveryRuleRouteConfigurationOverrideActionParameters'
          cacheConfiguration: {
            queryStringCachingBehavior: 'IgnoreSpecifiedQueryStrings'
            cacheBehavior: 'OverrideIfOriginMissing'
            cacheDuration: '23:59:59'
            isCompressionEnabled: 'Disabled'
            queryParameters: 'clientIp={client_ip}'
          }
        }
      }
    ]
    conditions: []
    matchProcessingBehavior: 'Continue'
    order: 1
  }
}
