param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource actionRule 'Microsoft.AlertsManagement/actionRules@2021-08-08' = {
  name: resourceName
  location: 'global'
  properties: {
    enabled: true
    scopes: []
    actions: [
      {
        actionType: 'RemoveAllActionGroups'
      }
    ]
    description: ''
  }
}
