param resourceName string = 'acctest0001'
param location string = 'westus'

resource application 'Microsoft.Solutions/applications@2021-07-01' = {
  name: '${resourceName}-app'
  location: location
  kind: 'ServiceCatalog'
  properties: {
    managedResourceGroupId: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceName}-infragroup'
    parameters: {
      intParameter: {
        value: 100
      }
      objectParameter: {
        value: {
          nested_bool: true
          nested_object: {
            key_0: 0
          }
          nested_array: [
            'value_1'
            'value_2'
          ]
        }
      }
      secureStringParameter: {
        value: ''
      }
      stringParameter: {
        value: 'value_1'
      }
      arrayParameter: {
        value: [
          'value_1'
          'value_2'
        ]
      }
      boolParameter: {
        value: true
      }
    }
  }
}

resource applicationDefinition 'Microsoft.Solutions/applicationDefinitions@2021-07-01' = {
  name: '${resourceName}-appdef'
  location: location
  properties: {
    displayName: 'TestManagedAppDefinition'
    isEnabled: true
    lockLevel: 'ReadOnly'
    mainTemplate: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
    authorizations: [
      {
        principalId: deployer().objectId
        roleDefinitionId: 'b24988ac-6180-42a0-ab88-20f7382dd24c'
      }
    ]
    createUiDefinition: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
    description: 'Test Managed App Definition'
  }
}
