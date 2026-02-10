param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource vault 'Microsoft.KeyVault/vaults@2021-10-01' = {
  name: resourceName
  location: location
  properties: {
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    publicNetworkAccess: 'Enabled'
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tenant()
    createMode: 'default'
    enableRbacAuthorization: false
    softDeleteRetentionInDays: 7
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
        tenantId: tenant()
      }
    ]
    enableSoftDelete: true
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
    publicNetworkAccess: 'Enabled'
    tls: {
      clientCertEnabled: false
    }
    disableAadAuth: false
    disableLocalAuth: false
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
