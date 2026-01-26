targetScope = 'subscription'

param resourceName string = 'acctest0001'

resource policyAssignment 'Microsoft.Authorization/policyAssignments@2022-06-01' = {
  name: resourceName
  properties: {
    displayName: ''
    enforcementMode: 'Default'
    policyDefinitionId: policyDefinition.id
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
          in: '[parameters(\'allowedLocations\')]'
        }
      }
      then: {
        effect: 'audit'
      }
    }
    policyType: 'Custom'
  }
}

resource policyExemption 'Microsoft.Authorization/policyExemptions@2020-07-01-preview' = {
  name: resourceName
  properties: {
    exemptionCategory: 'Mitigated'
    policyAssignmentId: policyAssignment.id
    policyDefinitionReferenceIds: []
  }
}
