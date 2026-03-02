param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource mediaService 'Microsoft.Media/mediaServices@2021-11-01' = {
  name: resourceName
  location: location
  properties: {
    storageAccounts: [
      {
        type: 'Primary'
      }
    ]
    publicNetworkAccess: 'Enabled'
  }
}

resource contentKeyPolicy 'Microsoft.Media/mediaServices/contentKeyPolicies@2022-08-01' = {
  name: resourceName
  parent: mediaService
  properties: {
    description: 'My Policy Description'
    options: [
      {
        configuration: {
          '@odata.type': '#Microsoft.Media.ContentKeyPolicyClearKeyConfiguration'
        }
        name: 'ClearKeyOption'
        restriction: {
          '@odata.type': '#Microsoft.Media.ContentKeyPolicyTokenRestriction'
          audience: 'urn:audience'
          issuer: 'urn:issuer'
          primaryVerificationKey: {
            '@odata.type': '#Microsoft.Media.ContentKeyPolicySymmetricTokenKey'
            keyValue: 'AAAAAAAAAAAAAAAAAAAAAA=='
          }
          requiredClaims: []
          restrictionTokenType: 'Swt'
        }
      }
    ]
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_GRS'
  }
  kind: 'StorageV2'
  properties: {
    defaultToOAuthAuthentication: false
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
    isNfsV3Enabled: false
    isSftpEnabled: false
    networkAcls: {
      defaultAction: 'Allow'
    }
    allowBlobPublicAccess: true
    isHnsEnabled: false
    minimumTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
    allowCrossTenantReplication: true
    allowSharedKeyAccess: true
  }
}
