param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource vault 'Microsoft.KeyVault/vaults@2021-10-01' = {
  name: resourceName
  location: location
  properties: {
    enableRbacAuthorization: false
    enabledForDeployment: false
    enabledForTemplateDeployment: false
    publicNetworkAccess: 'Enabled'
    sku: {
      family: 'A'
      name: 'standard'
    }
    softDeleteRetentionInDays: 7
    tenantId: tenant().tenantId
    accessPolicies: [
      {
        objectId: deployer().objectId
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
      }
    ]
    createMode: 'default'
    enableSoftDelete: true
    enabledForDiskEncryption: false
  }
}

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
