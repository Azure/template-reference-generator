param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource applicationgatewaywebapplicationfirewallpolicy 'Microsoft.Network/ApplicationGatewayWebApplicationFirewallPolicies@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    customRules: []
    managedRules: {
      exclusions: []
      managedRuleSets: [
        {
          ruleGroupOverrides: []
          ruleSetType: 'OWASP'
          ruleSetVersion: '3.1'
        }
      ]
    }
    policySettings: {
      fileUploadLimitInMb: 100
      maxRequestBodySizeInKb: 128
      mode: 'Detection'
      requestBodyCheck: true
      state: 'Enabled'
    }
  }
}
