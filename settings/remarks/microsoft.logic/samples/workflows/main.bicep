param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource workflow 'Microsoft.Logic/workflows@2019-05-01' = {
  name: resourceName
  location: location
  properties: {
    definition: {
      parameters: null
      triggers: {}
      '$schema': 'https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#'
      actions: {}
      contentVersion: '1.0.0.0'
    }
    parameters: {}
    state: 'Enabled'
  }
}
