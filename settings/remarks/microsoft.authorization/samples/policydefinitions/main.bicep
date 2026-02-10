targetScope = 'subscription'

param resourceName string = 'acctest0001'
param location string = 'eastus'

resource policyDefinition 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: resourceName
  properties: {
    description: ''
    displayName: 'my-policy-definition'
    mode: 'All'
    parameters: {
      allowedLocations: {
        type: 'Array'
        metadata: {
          description: 'The list of allowed locations for resources.'
          displayName: 'Allowed locations'
          strongType: 'location'
        }
      }
    }
    policyRule: {
      if: {
        not: {
          field: 'location'
          in: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
        }
      }
      then: {
        effect: 'audit'
      }
    }
    policyType: 'Custom'
  }
}
