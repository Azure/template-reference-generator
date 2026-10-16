@description('The name of the HorizonDB cluster')
param clusterName string = 'example-cluster'

resource horizonDbResource 'Microsoft.HorizonDb/clusters@2026-10-01-preview' = {
  name: clusterName
  location: 'eastus2'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '/subscriptions/ffffffff-ffff-ffff-ffff-ffffffffffff/resourceGroups/identity-resource-group/providers/Microsoft.ManagedIdentity/userAssignedIdentities/primary-encryption-identity': {
      }
    }
  }
  properties: {
    postgreSqlVersion: '17'
    backup: {
      geoRedundancy: 'Disabled'
      retentionDays: 14
    }
    dataEncryption: {
      type: 'AzureKeyVault'
      primaryKeyUri: 'https://primary-key-vault.vault.azure.net/keys/horizondb-primary-key'
      primaryUserAssignedIdentityId: '/subscriptions/ffffffff-ffff-ffff-ffff-ffffffffffff/resourceGroups/identity-resource-group/providers/Microsoft.ManagedIdentity/userAssignedIdentities/primary-encryption-identity'
    }
  }
}
