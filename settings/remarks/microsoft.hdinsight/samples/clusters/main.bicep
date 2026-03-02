@secure()
@description('The REST API credential password for the HDInsight cluster gateway')
param restCredentialPassword string
param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The username for the HDInsight cluster virtual machines')
param vmUsername string
@secure()
@description('The password for the HDInsight cluster virtual machines')
param vmPassword string

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2022-09-01' existing = {
  name: 'default'
  parent: storageAccount
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  name: resourceName
  parent: blobService
  properties: {
    metadata: {
      key: 'value'
    }
  }
}

resource cluster 'Microsoft.HDInsight/clusters@2018-06-01-preview' = {
  name: resourceName
  location: location
  properties: {
    encryptionInTransitProperties: {
      isEncryptionInTransitEnabled: false
    }
    osType: 'Linux'
    tier: 'standard'
    clusterDefinition: {
      componentVersion: {
        Spark: '2.4'
      }
      configurations: {
        gateway: {
          'restAuthCredential.isEnabled': true
          'restAuthCredential.password': restCredentialPassword
          'restAuthCredential.username': 'acctestusrgw'
        }
      }
      kind: 'Spark'
    }
    minSupportedTlsVersion: '1.2'
    storageProfile: {
      storageaccounts: [
        {
          isDefault: true
          key: storageAccount.listKeys().keys[0].value
          name: '.blob.core.windows.net'
        }
      ]
    }
    clusterVersion: '4.0.3000.1'
    computeProfile: {
      roles: [
        {
          osProfile: {
            linuxOperatingSystemProfile: {
              username: vmUsername
              password: vmPassword
            }
          }
          targetInstanceCount: 2
          hardwareProfile: {
            vmSize: 'standard_a4_v2'
          }
          name: 'headnode'
        }
        {
          targetInstanceCount: 3
          hardwareProfile: {
            vmSize: 'standard_a4_v2'
          }
          name: 'workernode'
          osProfile: {
            linuxOperatingSystemProfile: {
              password: vmPassword
              username: vmUsername
            }
          }
        }
        {
          targetInstanceCount: 3
          hardwareProfile: {
            vmSize: 'standard_a2_v2'
          }
          name: 'zookeepernode'
          osProfile: {
            linuxOperatingSystemProfile: {
              password: vmPassword
              username: vmUsername
            }
          }
        }
      ]
    }
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowCrossTenantReplication: true
    allowSharedKeyAccess: true
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
    minimumTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
    allowBlobPublicAccess: true
    defaultToOAuthAuthentication: false
    isHnsEnabled: false
    networkAcls: {
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
  }
}
