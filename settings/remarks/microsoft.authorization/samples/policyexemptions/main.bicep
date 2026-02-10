targetScope = 'subscription'

param resourceName string = 'acctest0001'
param location string = 'eastus'

resource policyExemption 'Microsoft.Authorization/policyExemptions@2020-07-01-preview' = {
  name: resourceName
  scope: subscription()
  properties: {
    exemptionCategory: 'Mitigated'
    policyAssignmentId: policyAssignment.id
    policyDefinitionReferenceIds: []
  }
}

resource policyAssignment 'Microsoft.Authorization/policyAssignments@2022-06-01' = {
  name: resourceName
  location: 'westeurope'
  scope: subscription()
  properties: {
    scope: subscription().id
    displayName: ''
    enforcementMode: 'Default'
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
          strongType: 'location'
          description: 'The list of allowed locations for resources.'
          displayName: 'Allowed locations'
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
