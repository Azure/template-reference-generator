param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource vault 'Microsoft.RecoveryServices/vaults@2022-10-01' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
  }
  sku: {
    name: 'Standard'
  }
}

resource replicationPolicy 'Microsoft.RecoveryServices/vaults/replicationPolicies@2022-10-01' = {
  parent: vault
  name: resourceName
  properties: {
    providerSpecificInput: {
      appConsistentFrequencyInMinutes: 240
      crashConsistentFrequencyInMinutes: 10
      enableMultiVmSync: 'True'
      instanceType: 'InMageRcm'
      recoveryPointHistoryInMinutes: 1440
    }
  }
}
