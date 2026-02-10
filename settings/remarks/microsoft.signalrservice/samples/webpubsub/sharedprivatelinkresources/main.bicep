param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource webPubSub 'Microsoft.SignalRService/webPubSub@2023-02-01' = {
  name: resourceName
  location: location
  sku: {
    capacity: 1
    name: 'Standard_S1'
  }
  properties: {
    disableAadAuth: false
    disableLocalAuth: false
    publicNetworkAccess: 'Enabled'
    tls: {
      clientCertEnabled: false
    }
  }
}

resource sharedPrivateLinkResource 'Microsoft.SignalRService/webPubSub/sharedPrivateLinkResources@2023-02-01' = {
  name: resourceName
  parent: webPubSub
  properties: {
    groupId: 'vault'
    privateLinkResourceId: vault.id
  }
}

resource vault 'Microsoft.KeyVault/vaults@2021-10-01' = {
  name: resourceName
  location: location
  properties: {
    createMode: 'default'
    enableRbacAuthorization: false
    enabledForDeployment: false
    sku: {
      name: 'standard'
      family: 'A'
    }
    softDeleteRetentionInDays: 7
    enableSoftDelete: true
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    publicNetworkAccess: 'Enabled'
    tenantId: tenant().tenantId
    accessPolicies: [
      {
        permissions: {
          certificates: [
            'ManageContacts'
          ]
          keys: [
            'Create'
          ]
          secrets: [
            'Set'
          ]
          storage: []
        }
        tenantId: tenant().tenantId
        objectId: deployer().objectId
      }
    ]
  }
}
