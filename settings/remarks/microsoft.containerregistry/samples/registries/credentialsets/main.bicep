param resourceName string = 'acctest0001'
param location string = 'eastus'
@secure()
@description('The username for the container registry credential')
param credentialUsername string = 'testuser'
@secure()
@description('The password for the container registry credential')
param credentialPassword string

resource vault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: '${resourceName}vault'
  location: location
  properties: {
    enableRbacAuthorization: false
    enableSoftDelete: true
    enabledForTemplateDeployment: false
    publicNetworkAccess: 'Enabled'
    tenantId: tenant().tenantId
    accessPolicies: [
      {
        objectId: deployer().objectId
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
      }
    ]
    enabledForDeployment: false
    enabledForDiskEncryption: false
    sku: {
      family: 'A'
      name: 'standard'
    }
    softDeleteRetentionInDays: 7
    createMode: 'default'
  }
}

resource registry 'Microsoft.ContainerRegistry/registries@2023-11-01-preview' = {
  name: resourceName
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    networkRuleBypassOptions: 'AzureServices'
    policies: {
      exportPolicy: {
        status: 'enabled'
      }
      quarantinePolicy: {
        status: 'disabled'
      }
      retentionPolicy: {}
      trustPolicy: {}
    }
    publicNetworkAccess: 'Enabled'
    zoneRedundancy: 'Disabled'
    adminUserEnabled: false
    anonymousPullEnabled: false
    dataEndpointEnabled: false
  }
}

resource credentialSet 'Microsoft.ContainerRegistry/registries/credentialSets@2023-07-01' = {
  name: '${resourceName}-acr-credential-set'
  parent: registry
  properties: {
    authCredentials: [
      {
        usernameSecretIdentifier: 'https://${resourceName}vault.vault.azure.net/secrets/username'
        name: 'Credential1'
        passwordSecretIdentifier: 'https://${resourceName}vault.vault.azure.net/secrets/password'
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
