targetScope = 'subscription'

param location string = 'eastus'
param resourceName string = 'acctest0001'

resource policyAssignment 'Microsoft.Authorization/policyAssignments@2022-06-01' = {
  name: resourceName
  location: 'westeurope'
  scope: subscription()
  properties: {
    displayName: ''
    enforcementMode: 'Default'
    scope: subscription().id
  }
}

resource policyDefinition 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: resourceName
  properties: {
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
    description: ''
    displayName: 'my-policy-definition'
    mode: 'All'
    parameters: {
      allowedLocations: {
        type: 'Array'
        metadata: {
          strongType: 'location'
          description: 'The list of allowed locations for resources.'
          displayName: 'Allowed locations'
        }
      }
    }
  }
}

resource policyExemption 'Microsoft.Authorization/policyExemptions@2020-07-01-preview' = {
  name: resourceName
  scope: subscription()
  properties: {
    exemptionCategory: 'Mitigated'
    policyAssignmentId: policyAssignment.id
    policyDefinitionReferenceIds: []
  }
}
