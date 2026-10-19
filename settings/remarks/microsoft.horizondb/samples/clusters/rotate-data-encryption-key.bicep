@description('The name of the HorizonDB cluster')
param clusterName string = 'example-cluster'

resource horizonDbResource 'Microsoft.HorizonDb/clusters@2026-10-01-preview' = {
  name: clusterName
  properties: {
    dataEncryption: {
      primaryKeyUri: 'https://primary-key-vault.vault.azure.net/keys/horizondb-primary-key'
    }
  }
}
