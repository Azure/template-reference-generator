param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_GRS'
  }
  kind: 'StorageV2'
  properties: {
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
    allowSharedKeyAccess: true
    defaultToOAuthAuthentication: false
    isNfsV3Enabled: false
    encryption: {
      keySource: 'Microsoft.Storage'
      services: {
        table: {
          keyType: 'Service'
        }
        queue: {
          keyType: 'Service'
        }
      }
    }
    isHnsEnabled: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
  }
}

resource mediaService 'Microsoft.Media/mediaServices@2021-11-01' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
    storageAccounts: [
      {
        type: 'Primary'
      }
    ]
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
          restrictionTokenType: 'Swt'
          '@odata.type': '#Microsoft.Media.ContentKeyPolicyTokenRestriction'
          audience: 'urn:audience'
          issuer: 'urn:issuer'
          primaryVerificationKey: {
            '@odata.type': '#Microsoft.Media.ContentKeyPolicySymmetricTokenKey'
            keyValue: 'AAAAAAAAAAAAAAAAAAAAAA=='
          }
          requiredClaims: []
        }
      }
    ]
  }
}
