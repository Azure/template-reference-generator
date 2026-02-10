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

resource ruleSet 'Microsoft.Cdn/profiles/ruleSets@2024-09-01' = {
  name: 'ruleSet${substring(resourceName, (length(resourceName) - 4), 3)}'
  parent: profile
}

resource rule 'Microsoft.Cdn/profiles/ruleSets/rules@2024-09-01' = {
  name: 'rule${substring(resourceName, (length(resourceName) - 4), 3)}'
  parent: ruleSet
  properties: {
    actions: [
      {
        name: 'RouteConfigurationOverride'
        parameters: {
          typeName: 'DeliveryRuleRouteConfigurationOverrideActionParameters'
          cacheConfiguration: {
            isCompressionEnabled: 'Disabled'
            queryParameters: 'clientIp={client_ip}'
            queryStringCachingBehavior: 'IgnoreSpecifiedQueryStrings'
            cacheBehavior: 'OverrideIfOriginMissing'
            cacheDuration: '23:59:59'
          }
          originGroupOverride: {
            forwardingProtocol: 'HttpsOnly'
            originGroup: {
              id: originGroup.id
            }
          }
        }
      }
    ]
    conditions: []
    matchProcessingBehavior: 'Continue'
    order: 1
  }
}

resource originGroup 'Microsoft.Cdn/profiles/originGroups@2024-09-01' = {
  name: '${resourceName}-origingroup'
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

resource origin 'Microsoft.Cdn/profiles/originGroups/origins@2024-09-01' = {
  name: '${resourceName}-origin'
  parent: originGroup
  properties: {
    enforceCertificateNameCheck: false
    hostName: 'contoso.com'
    httpPort: 80
    originHostHeader: 'www.contoso.com'
    priority: 1
    weight: 1
    enabledState: 'Enabled'
    httpsPort: 443
  }
}
