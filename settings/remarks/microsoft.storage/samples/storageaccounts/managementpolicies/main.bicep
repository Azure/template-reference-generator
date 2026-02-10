param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'BlobStorage'
  properties: {
    accessTier: 'Hot'
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
    isHnsEnabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
    allowSharedKeyAccess: true
    isNfsV3Enabled: false
    isSftpEnabled: false
    publicNetworkAccess: 'Enabled'
  }
}

resource managementPolicy 'Microsoft.Storage/storageAccounts/managementPolicies@2021-09-01' = {
  name: 'default'
  parent: storageAccount
  properties: {
    policy: {
      rules: [
        {
          definition: {
            actions: {
              snapshot: {
                delete: {
                  daysAfterCreationGreaterThan: 30
                }
              }
              baseBlob: {
                tierToCool: {
                  daysAfterModificationGreaterThan: 10
                }
                delete: {
                  daysAfterModificationGreaterThan: 100
                }
                tierToArchive: {
                  daysAfterModificationGreaterThan: 50
                }
              }
            }
            filters: {
              prefixMatch: [
                'container1/prefix1'
              ]
              blobTypes: [
                'blockBlob'
              ]
            }
          }
          enabled: true
          name: 'rule-1'
          type: 'Lifecycle'
        }
      ]
    }
  }
}
