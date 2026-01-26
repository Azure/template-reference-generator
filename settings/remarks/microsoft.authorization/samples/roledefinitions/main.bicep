targetScope = 'subscription'

param resourceName string = 'acctest0001'

resource roleDefinition 'Microsoft.Authorization/roleDefinitions@2018-01-01-preview' = {
  name: '6faae21a-0cd6-4536-8c23-a278823d12ed'
  properties: {
    assignableScopes: [
      subscription().id
    ]
    description: ''
    permissions: [
      {
        actions: [
          '*'
        ]
        dataActions: []
        notActions: []
        notDataActions: []
      }
    ]
    roleName: 'acctest0001'
    type: 'CustomRole'
  }
}
