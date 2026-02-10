targetScope = 'subscription'

param resourceName string = 'acctest0001'
param location string = 'eastus'

resource roleDefinition 'Microsoft.Authorization/roleDefinitions@2018-01-01-preview' = {
  name: '6faae21a-0cd6-4536-8c23-a278823d12ed'
  properties: {
    assignableScopes: [
      subscription().id
    ]
    description: ''
    permissions: [
      {
        notDataActions: []
        actions: [
          '*'
        ]
        dataActions: []
        notActions: []
      }
    ]
    roleName: resourceName
    type: 'CustomRole'
  }
}
