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
    cors: {}
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
    serverless: {
      connectionTimeoutInSeconds: 30
    }
    upstream: {
      templates: []
    }
    disableAadAuth: false
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
          name: 'HttpRequestLogs'
          enabled: 'false'
        }
      ]
    }
    tls: {
      clientCertEnabled: false
    }
  }
}

resource vault 'Microsoft.KeyVault/vaults@2021-10-01' = {
  name: resourceName
  location: location
  properties: {
    tenantId: tenant()
    createMode: 'default'
    enabledForDeployment: false
    enabledForDiskEncryption: false
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
    enableRbacAuthorization: false
    enableSoftDelete: true
    enabledForTemplateDeployment: false
    publicNetworkAccess: 'Enabled'
    sku: {
      family: 'A'
      name: 'standard'
    }
  }
}

resource sharedPrivateLinkResource 'Microsoft.SignalRService/signalR/sharedPrivateLinkResources@2023-02-01' = {
  name: resourceName
  parent: signalR
  properties: {
    requestMessage: 'please approve'
    groupId: 'vault'
    privateLinkResourceId: vault.id
  }
}
