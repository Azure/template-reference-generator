param resourceName string = 'acctest0001'
param location string = 'westus'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: '${resourceName}sa'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    isHnsEnabled: false
    isNfsV3Enabled: false
    supportsHttpsTrafficOnly: true
    encryption: {
      keySource: 'Microsoft.Storage'
      services: {
        queue: {
          keyType: 'Service'
        }
        table: {
          keyType: 'Service'
        }
      }
    }
    isLocalUserEnabled: true
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      resourceAccessRules: []
      virtualNetworkRules: []
    }
    isSftpEnabled: false
    publicNetworkAccess: 'Enabled'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: false
    allowSharedKeyAccess: true
    defaultToOAuthAuthentication: false
    dnsEndpointType: 'Standard'
    minimumTlsVersion: 'TLS1_2'
  }
}

resource vault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: '${resourceName}-kv'
  location: location
  dependsOn: [
    storageAccount
  ]
  properties: {
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tenant().tenantId
    accessPolicies: [
      {
        objectId: deployer().objectId
        permissions: {
          secrets: []
          storage: []
          certificates: []
          keys: [
            'Get'
            'Create'
            'Delete'
            'List'
            'Restore'
            'Recover'
            'UnwrapKey'
            'WrapKey'
            'Purge'
            'Encrypt'
            'Decrypt'
            'Sign'
            'Verify'
            'GetRotationPolicy'
          ]
        }
        tenantId: tenant().tenantId
      }
      {
        objectId: storageAccount.identity.principalId
        permissions: {
          certificates: []
          keys: [
            'Get'
            'UnwrapKey'
            'WrapKey'
          ]
          secrets: []
          storage: []
        }
        tenantId: tenant().tenantId
      }
    ]
    createMode: 'default'
    publicNetworkAccess: 'Enabled'
    enablePurgeProtection: true
    enableRbacAuthorization: false
    enableSoftDelete: true
    enabledForDeployment: false
  }
}

resource encryptionScope 'Microsoft.Storage/storageAccounts/encryptionScopes@2023-05-01' = {
  name: '${resourceName}-scope'
  parent: storageAccount
  dependsOn: [
    vault
  ]
  properties: {
    source: 'Microsoft.KeyVault'
    state: 'Enabled'
    keyVaultProperties: {}
  }
}

resource key 'Microsoft.KeyVault/vaults/keys@2023-02-01' = {
  name: '${resourceName}-key'
  parent: vault
  properties: {
    keyOps: [
      'encrypt'
      'decrypt'
      'sign'
      'verify'
      'wrapKey'
      'unwrapKey'
    ]
    keySize: 2048
    kty: 'RSA'
  }
}
