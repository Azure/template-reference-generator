param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource frontDoorWebApplicationFirewallPolicy 'Microsoft.Network/FrontDoorWebApplicationFirewallPolicies@2020-11-01' = {
  name: resourceName
  location: 'global'
  sku: {
    name: 'Premium_AzureFrontDoor'
  }
  properties: {
    policySettings: {
      customBlockResponseBody: 'PGh0bWw+CjxoZWFkZXI+PHRpdGxlPkhlbGxvPC90aXRsZT48L2hlYWRlcj4KPGJvZHk+CkhlbGxvIHdvcmxkCjwvYm9keT4KPC9odG1sPg=='
      customBlockResponseStatusCode: 403
      enabledState: 'Enabled'
      mode: 'Prevention'
      redirectUrl: 'https://www.fabrikam.com'
    }
    customRules: {
      rules: [
        {
          action: 'Block'
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
          name: 'Rule1'
          priority: 1
          rateLimitDurationInMinutes: 1
          enabledState: 'Enabled'
          rateLimitThreshold: 10
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
          ruleSetVersion: 'preview-0.1'
          ruleSetAction: 'Block'
          ruleSetType: 'BotProtection'
        }
      ]
    }
  }
}
