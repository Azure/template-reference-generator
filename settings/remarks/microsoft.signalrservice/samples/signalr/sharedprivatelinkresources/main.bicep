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
    resourceLogConfiguration: {
      categories: [
        {
          name: 'MessagingLogs'
          enabled: 'false'
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
    tls: {
      clientCertEnabled: false
    }
    disableLocalAuth: false
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
    serverless: {
      connectionTimeoutInSeconds: 30
    }
    upstream: {
      templates: []
    }
    cors: {}
    disableAadAuth: false
    publicNetworkAccess: 'Enabled'
  }
}

resource vault 'Microsoft.KeyVault/vaults@2021-10-01' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
    sku: {
      name: 'standard'
      family: 'A'
    }
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
    enableRbacAuthorization: false
    enableSoftDelete: true
    enabledForDiskEncryption: false
    softDeleteRetentionInDays: 7
    tenantId: tenant().tenantId
    createMode: 'default'
    enabledForDeployment: false
    enabledForTemplateDeployment: false
  }
}

resource sharedPrivateLinkResource 'Microsoft.SignalRService/signalR/sharedPrivateLinkResources@2023-02-01' = {
  name: resourceName
  parent: signalR
  properties: {
    privateLinkResourceId: vault.id
    requestMessage: 'please approve'
    groupId: 'vault'
  }
}
