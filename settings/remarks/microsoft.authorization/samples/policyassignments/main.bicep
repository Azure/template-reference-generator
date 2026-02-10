targetScope = 'subscription'

param resourceName string = 'acctest0001'
param location string = 'eastus'

resource policyAssignment 'Microsoft.Authorization/policyAssignments@2022-06-01' = {
  name: resourceName
  scope: subscription()
  properties: {
    displayName: ''
    enforcementMode: 'Default'
    parameters: {
      listOfAllowedLocations: {
        value: [
          'West Europe'
          'West US 2'
          'East US 2'
        ]
      }
    }
    scope: subscription().id
  }
}

resource policyDefinition 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: resourceName
  properties: {
    description: ''
    displayName: 'my-policy-definition'
    mode: 'All'
    parameters: {
      allowedLocations: {
        metadata: {
          description: 'The list of allowed locations for resources.'
          displayName: 'Allowed locations'
          strongType: 'location'
        }
        type: 'Array'
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
