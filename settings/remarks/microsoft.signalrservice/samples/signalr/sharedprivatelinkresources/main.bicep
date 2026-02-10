param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource signalR 'Microsoft.SignalRService/signalR@2023-02-01' = {
  name: resourceName
  location: location
  sku: {
    capacity: 1
    name: 'Standard_S1'
  }
  properties: {
    upstream: {
      templates: []
    }
    cors: {}
    disableLocalAuth: false
    publicNetworkAccess: 'Enabled'
    disableAadAuth: false
    features: [
      {
        flag: 'ServiceMode'
        value: 'Default'
      }
      {
        flag: 'EnableConnectivityLogs'
        value: 'False'
      }
      {
        flag: 'EnableMessagingLogs'
        value: 'False'
      }
      {
        flag: 'EnableLiveTrace'
        value: 'False'
      }
    ]
    resourceLogConfiguration: {
      categories: [
        {
          enabled: 'false'
          name: 'MessagingLogs'
        }
        {
          enabled: 'false'
          name: 'ConnectivityLogs'
        }
        {
          enabled: 'false'
          name: 'HttpRequestLogs'
        }
      ]
    }
    serverless: {
      connectionTimeoutInSeconds: 30
    }
    tls: {
      clientCertEnabled: false
    }
  }
}

resource sharedPrivateLinkResource 'Microsoft.SignalRService/signalR/sharedPrivateLinkResources@2023-02-01' = {
  name: resourceName
  parent: signalR
  properties: {
    groupId: 'vault'
    privateLinkResourceId: vault.id
    requestMessage: 'please approve'
  }
}

resource vault 'Microsoft.KeyVault/vaults@2021-10-01' = {
  name: resourceName
  location: location
  properties: {
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
    enabledForDeployment: false
    enabledForTemplateDeployment: false
    publicNetworkAccess: 'Enabled'
    enableRbacAuthorization: false
    enabledForDiskEncryption: false
    sku: {
      family: 'A'
      name: 'standard'
    }
    softDeleteRetentionInDays: 7
    tenantId: tenant().tenantId
  }
}
