@secure()
@description('The username for the container registry credential')
param credentialUsername string = 'testuser'
@secure()
@description('The password for the container registry credential')
param credentialPassword string
param resourceName string = 'acctest0001'
param location string = 'eastus'

resource registry 'Microsoft.ContainerRegistry/registries@2023-11-01-preview' = {
  name: resourceName
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: false
    anonymousPullEnabled: false
    dataEndpointEnabled: false
    networkRuleBypassOptions: 'AzureServices'
    policies: {
      quarantinePolicy: {
        status: 'disabled'
      }
      retentionPolicy: {}
      trustPolicy: {}
      exportPolicy: {
        status: 'enabled'
      }
    }
    publicNetworkAccess: 'Enabled'
    zoneRedundancy: 'Disabled'
  }
}

resource vault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: '${resourceName}vault'
  location: location
  properties: {
    accessPolicies: [
      {
        permissions: {
          certificates: []
          keys: []
          secrets: [
            'Get'
            'Set'
            'Delete'
            'Purge'
          ]
          storage: []
        }
        tenantId: tenant().tenantId
        objectId: deployer().objectId
      }
    ]
    enableRbacAuthorization: false
    enableSoftDelete: true
    enabledForDeployment: false
    enabledForDiskEncryption: false
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tenant().tenantId
    createMode: 'default'
    enabledForTemplateDeployment: false
    publicNetworkAccess: 'Enabled'
    softDeleteRetentionInDays: 7
  }
}

resource credentialSet 'Microsoft.ContainerRegistry/registries/credentialSets@2023-07-01' = {
  name: '${resourceName}-acr-credential-set'
  parent: registry
  properties: {
    authCredentials: [
      {
        name: 'Credential1'
        passwordSecretIdentifier: 'https://${resourceName}vault.vault.azure.net/secrets/password'
        usernameSecretIdentifier: 'https://${resourceName}vault.vault.azure.net/secrets/username'
      }
    ]
    loginServer: 'docker.io'
  }
}

resource passwordSecret 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = {
  name: 'password'
  parent: vault
  properties: {
    value: '${credentialPassword}'
  }
}

resource usernameSecret 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = {
  name: 'username'
  parent: vault
  properties: {
    value: '${credentialUsername}'
  }
}
