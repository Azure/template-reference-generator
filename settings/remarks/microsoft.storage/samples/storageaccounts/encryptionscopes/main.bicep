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
    allowBlobPublicAccess: true
    allowCrossTenantReplication: false
    defaultToOAuthAuthentication: false
    minimumTlsVersion: 'TLS1_2'
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
    isHnsEnabled: false
    isLocalUserEnabled: true
    networkAcls: {
      resourceAccessRules: []
      virtualNetworkRules: []
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
    }
    publicNetworkAccess: 'Enabled'
    allowSharedKeyAccess: true
    dnsEndpointType: 'Standard'
    isNfsV3Enabled: false
    isSftpEnabled: false
  }
}

resource vault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: '${resourceName}-kv'
  location: location
  dependsOn: [
    storageAccount
  ]
  properties: {
    createMode: 'default'
    enableRbacAuthorization: false
    enableSoftDelete: true
    enabledForDiskEncryption: false
    publicNetworkAccess: 'Enabled'
    tenantId: tenant().tenantId
    accessPolicies: [
      {
        permissions: {
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
          secrets: []
          storage: []
          certificates: []
        }
        tenantId: tenant().tenantId
        objectId: deployer().objectId
      }
      {
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
        objectId: storageAccount.identity.principalId
      }
    ]
    enablePurgeProtection: true
    enabledForDeployment: false
    enabledForTemplateDeployment: false
    sku: {
      family: 'A'
      name: 'standard'
    }
  }
}

resource encryptionScope 'Microsoft.Storage/storageAccounts/encryptionScopes@2023-05-01' = {
  name: '${resourceName}-scope'
  parent: storageAccount
  dependsOn: [
    vault
  ]
  properties: {
    keyVaultProperties: {}
    source: 'Microsoft.KeyVault'
    state: 'Enabled'
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
