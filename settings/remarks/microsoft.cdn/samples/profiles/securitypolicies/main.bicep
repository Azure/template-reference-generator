param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource frontDoorWebApplicationFirewallPolicy 'Microsoft.Network/FrontDoorWebApplicationFirewallPolicies@2020-11-01' = {
  name: resourceName
  location: 'global'
  sku: {
    name: 'Premium_AzureFrontDoor'
  }
  properties: {
    customRules: {
      rules: [
        {
          action: 'Block'
          enabledState: 'Enabled'
          matchConditions: [
            {
              matchValue: [
                '192.168.1.0/24'
                '10.0.0.0/24'
              ]
              matchVariable: 'RemoteAddr'
              negateCondition: false
              operator: 'IPMatch'
            }
          ]
          priority: 1
          rateLimitThreshold: 10
          name: 'Rule1'
          rateLimitDurationInMinutes: 1
          ruleType: 'MatchRule'
        }
      ]
    }
    managedRules: {
      managedRuleSets: [
        {
          ruleGroupOverrides: [
            {
              ruleGroupName: 'PHP'
              rules: [
                {
                  action: 'Block'
                  enabledState: 'Disabled'
                  ruleId: '933111'
                }
              ]
            }
          ]
          ruleSetAction: 'Block'
          ruleSetType: 'DefaultRuleSet'
          ruleSetVersion: 'preview-0.1'
        }
        {
          ruleSetAction: 'Block'
          ruleSetType: 'BotProtection'
          ruleSetVersion: 'preview-0.1'
        }
      ]
    }
    policySettings: {
      customBlockResponseBody: 'PGh0bWw+CjxoZWFkZXI+PHRpdGxlPkhlbGxvPC90aXRsZT48L2hlYWRlcj4KPGJvZHk+CkhlbGxvIHdvcmxkCjwvYm9keT4KPC9odG1sPg=='
      customBlockResponseStatusCode: 403
      enabledState: 'Enabled'
      mode: 'Prevention'
      redirectUrl: 'https://www.fabrikam.com'
    }
  }
}

resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: '${resourceName}.com'
  location: 'global'
}

resource profile 'Microsoft.Cdn/profiles@2021-06-01' = {
  name: resourceName
  location: 'global'
  sku: {
    name: 'Premium_AzureFrontDoor'
  }
  properties: {
    originResponseTimeoutSeconds: 120
  }
}

resource customDomain 'Microsoft.Cdn/profiles/customDomains@2021-06-01' = {
  name: resourceName
  parent: profile
  properties: {
    azureDnsZone: {
      id: dnsZone.id
    }
    hostName: 'fabrikam.${resourceName}.com'
    tlsSettings: {
      certificateType: 'ManagedCertificate'
      minimumTlsVersion: 'TLS12'
    }
  }
}

resource securityPolicy 'Microsoft.Cdn/profiles/securityPolicies@2021-06-01' = {
  name: resourceName
  parent: profile
  properties: {
    parameters: {
      associations: [
        {
          domains: [
            {
              id: customDomain.id
            }
          ]
          patternsToMatch: [
            '/*'
          ]
        }
      ]
      type: 'WebApplicationFirewall'
      wafPolicy: {
        id: frontDoorWebApplicationFirewallPolicy.id
      }
    }
  }
}
