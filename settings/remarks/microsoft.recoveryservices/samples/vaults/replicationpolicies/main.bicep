param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource vault 'Microsoft.RecoveryServices/vaults@2022-10-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}

resource replicationPolicy 'Microsoft.RecoveryServices/vaults/replicationPolicies@2022-10-01' = {
  name: resourceName
  parent: vault
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
