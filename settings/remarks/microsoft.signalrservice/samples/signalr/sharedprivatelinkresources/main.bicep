param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource signalR 'Microsoft.SignalRService/signalR@2023-02-01' = {
  name: resourceName
  location: location
  properties: {
    cors: {}
    disableAadAuth: false
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
    publicNetworkAccess: 'Enabled'
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
    upstream: {
      templates: []
    }
  }
  sku: {
    capacity: 1
    name: 'Standard_S1'
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
        tenantId: deployer().tenantId
      }
    ]
    createMode: 'default'
    enableRbacAuthorization: false
    enableSoftDelete: true
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    publicNetworkAccess: 'Enabled'
    sku: {
      family: 'A'
      name: 'standard'
    }
    softDeleteRetentionInDays: 7
    tenantId: deployer().tenantId
  }
}

resource sharedPrivateLinkResource 'Microsoft.SignalRService/signalR/sharedPrivateLinkResources@2023-02-01' = {
  parent: signalR
  name: resourceName
  properties: {
    groupId: 'vault'
    privateLinkResourceId: vault.id
    requestMessage: 'please approve'
  }
}
