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
    allowSharedKeyAccess: true
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
    isHnsEnabled: false
    isLocalUserEnabled: true
    isNfsV3Enabled: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      resourceAccessRules: []
      virtualNetworkRules: []
    }
    publicNetworkAccess: 'Enabled'
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
    accessPolicies: [
      {
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
    enablePurgeProtection: true
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
    tenantId: tenant().tenantId
  }
}

resource encryptionScope 'Microsoft.Storage/storageAccounts/encryptionScopes@2023-05-01' = {
  name: '${resourceName}-scope'
  parent: storageAccount
  dependsOn: [
    vault
  ]
  properties: {
    keyVaultProperties: {
      keyUri: key.properties.keyUriWithVersion
    }
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
