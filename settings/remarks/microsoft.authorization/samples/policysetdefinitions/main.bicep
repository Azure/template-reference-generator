targetScope = 'subscription'

param resourceName string = 'acctest0001'
param location string = 'westus'

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
      then: {
        effect: 'audit'
      }
      if: {
        not: {
          field: 'location'
          in: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
        }
      }
    }
    policyType: 'Custom'
  }
}

resource policySetDefinition 'Microsoft.Authorization/policySetDefinitions@2025-01-01' = {
  name: 'acctestpolset-${resourceName}'
  properties: {
    description: ''
    displayName: 'acctestpolset-${resourceName}'
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
    policyDefinitions: [
      {
        parameters: {
          listOfAllowedLocations: {
            value: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
          }
        }
        policyDefinitionId: policyDefinition.id
        policyDefinitionReferenceId: ''
        groupNames: []
      }
    ]
    policyType: 'Custom'
  }
}
