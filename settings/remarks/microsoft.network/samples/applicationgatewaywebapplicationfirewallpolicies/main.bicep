param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource applicationGatewayWebApplicationFirewallPolicy 'Microsoft.Network/ApplicationGatewayWebApplicationFirewallPolicies@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    managedRules: {
      exclusions: []
      managedRuleSets: [
        {
          ruleSetVersion: '3.1'
          ruleGroupOverrides: []
          ruleSetType: 'OWASP'
        }
      ]
    }
    policySettings: {
      maxRequestBodySizeInKb: 128
      mode: 'Detection'
      requestBodyCheck: true
      state: 'Enabled'
      fileUploadLimitInMb: 100
    }
    customRules: []
  }
}
