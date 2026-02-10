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
    defaultToOAuthAuthentication: false
    dnsEndpointType: 'Standard'
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
    allowSharedKeyAccess: true
    networkAcls: {
      resourceAccessRules: []
      virtualNetworkRules: []
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
    }
    minimumTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: false
    isHnsEnabled: false
    isLocalUserEnabled: true
    isNfsV3Enabled: false
    accessTier: 'Hot'
    isSftpEnabled: false
    supportsHttpsTrafficOnly: true
  }
}

resource vault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: '${resourceName}-kv'
  location: location
  dependsOn: [
    storageAccount
  ]
  properties: {
    enablePurgeProtection: true
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tenant()
    createMode: 'default'
    enableRbacAuthorization: false
    enableSoftDelete: true
    enabledForDeployment: false
    publicNetworkAccess: 'Enabled'
    accessPolicies: [
      {
        tenantId: tenant()
        objectId: deployer().objectId
        permissions: {
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
          secrets: []
          storage: []
        }
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
        tenantId: tenant()
      }
    ]
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
    keySize: 2048
    kty: 'RSA'
    keyOps: [
      'encrypt'
      'decrypt'
      'sign'
      'verify'
      'wrapKey'
      'unwrapKey'
    ]
  }
}
