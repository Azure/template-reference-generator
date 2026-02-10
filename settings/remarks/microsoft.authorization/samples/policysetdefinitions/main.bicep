targetScope = 'subscription'

param location string = 'westus'
param resourceName string = 'acctest0001'

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

resource policySetDefinition 'Microsoft.Authorization/policySetDefinitions@2025-01-01' = {
  name: 'acctestpolset-${resourceName}'
  properties: {
    policyType: 'Custom'
    description: ''
    displayName: 'acctestpolset-${resourceName}'
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
    policyDefinitions: [
      {
        groupNames: []
        parameters: {
          listOfAllowedLocations: {
            value: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
          }
        }
        policyDefinitionId: policyDefinition.id
        policyDefinitionReferenceId: ''
      }
    ]
  }
}
