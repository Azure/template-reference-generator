param resourceName string = 'acctest0001'
param location string = 'westus'

resource application 'Microsoft.Solutions/applications@2021-07-01' = {
  name: '${resourceName}-app'
  location: location
  kind: 'ServiceCatalog'
  properties: {
    applicationDefinitionId: applicationDefinition.id
    managedResourceGroupId: '/subscriptions/subscription().subscriptionId/resourceGroups/acctest0001-infragroup'
    parameters: {
      arrayParameter: {
        value: [
          'value_1'
          'value_2'
        ]
      }
      boolParameter: {
        value: true
      }
      intParameter: {
        value: 100
      }
      objectParameter: {
        value: {
          nested_array: [
            'value_1'
            'value_2'
          ]
          nested_bool: true
          nested_object: {
            key_0: 0
          }
        }
      }
      secureStringParameter: {
        value: ''
      }
      stringParameter: {
        value: 'value_1'
      }
    }
  }
}

resource applicationDefinition 'Microsoft.Solutions/applicationDefinitions@2021-07-01' = {
  name: '${resourceName}-appdef'
  location: location
  properties: {
    authorizations: [
      {
        principalId: deployer().objectId
        roleDefinitionId: 'b24988ac-6180-42a0-ab88-20f7382dd24c'
      }
    ]
    createUiDefinition: '''    {
      "$schema": "https://schema.management.azure.com/schemas/0.1.2-preview/CreateUIDefinition.MultiVm.json#",
      "handler": "Microsoft.Azure.CreateUIDef",
      "version": "0.1.2-preview",
      "parameters": {
         "basics": [],
         "steps": [],
         "outputs": {}
      }
    }
'''
    description: 'Test Managed App Definition'
    displayName: 'TestManagedAppDefinition'
    isEnabled: true
    lockLevel: 'ReadOnly'
    mainTemplate: '''    {
      "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
      "contentVersion": "1.0.0.0",
      "parameters": {

         "boolParameter": {
            "type": "bool"
         },
         "intParameter": {
            "type": "int"
         },
         "stringParameter": {
            "type": "string"
         },
         "secureStringParameter": {
            "type": "secureString"
         },
         "objectParameter": {
            "type": "object"
         },
         "arrayParameter": {
            "type": "array"
         }

      },
      "variables": {},
      "resources": [],
      "outputs": {
        "boolOutput": {
          "type": "bool",
          "value": true
        },
        "intOutput": {
          "type": "int",
          "value": 100
        },
        "stringOutput": {
          "type": "string",
          "value": "stringOutputValue"
        },
        "objectOutput": {
          "type": "object",
          "value": {
            "nested_bool": true,
            "nested_array": ["value_1", "value_2"],
            "nested_object": {
              "key_0": 0
            }
          }
        },
        "arrayOutput": {
          "type": "array",
          "value": ["value_1", "value_2"]
        }
      }
    }
'''
  }
}
