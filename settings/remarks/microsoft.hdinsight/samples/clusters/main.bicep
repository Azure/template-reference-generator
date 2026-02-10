param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The username for the HDInsight cluster virtual machines')
param vmUsername string
@secure()
@description('The password for the HDInsight cluster virtual machines')
param vmPassword string
@secure()
@description('The REST API credential password for the HDInsight cluster gateway')
param restCredentialPassword string

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2022-09-01' existing = {
  name: 'default'
  parent: storageAccount
}

resource cluster 'Microsoft.HDInsight/clusters@2018-06-01-preview' = {
  name: resourceName
  location: location
  properties: {
    clusterDefinition: {
      configurations: {
        gateway: {
          'restAuthCredential.password': restCredentialPassword
          'restAuthCredential.username': 'acctestusrgw'
          'restAuthCredential.isEnabled': true
        }
      }
      kind: 'Spark'
      componentVersion: {
        Spark: '2.4'
      }
    }
    clusterVersion: '4.0.3000.1'
    computeProfile: {
      roles: [
        {
          name: 'headnode'
          osProfile: {
            linuxOperatingSystemProfile: {
              password: vmPassword
              username: vmUsername
            }
          }
          targetInstanceCount: 2
          hardwareProfile: {
            vmSize: 'standard_a4_v2'
          }
        }
        {
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
          targetInstanceCount: 3
        }
        {
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
          targetInstanceCount: 3
        }
      ]
    }
    encryptionInTransitProperties: {
      isEncryptionInTransitEnabled: false
    }
    minSupportedTlsVersion: '1.2'
    osType: 'Linux'
    storageProfile: {
      storageaccounts: [
        {
          isDefault: true
          key: storageAccount.listKeys().keys[0].value
          name: '.blob.core.windows.net'
        }
      ]
    }
    tier: 'standard'
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
    minimumTlsVersion: 'TLS1_2'
    isHnsEnabled: false
    isSftpEnabled: false
    networkAcls: {
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
    allowSharedKeyAccess: true
    defaultToOAuthAuthentication: false
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
    isNfsV3Enabled: false
  }
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
