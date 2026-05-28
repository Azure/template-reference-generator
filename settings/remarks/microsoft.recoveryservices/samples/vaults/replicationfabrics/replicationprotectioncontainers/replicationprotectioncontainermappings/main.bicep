param resourceName string = 'acctest0001'
param location string = 'westus'

resource vault 'Microsoft.RecoveryServices/vaults@2024-01-01' = {
  name: 'acctest-vault-250703130022502990'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
    redundancySettings: {
      crossRegionRestore: 'Disabled'
      standardTierStorageRedundancy: 'GeoRedundant'
    }
  }
}

resource replicationFabric 'Microsoft.RecoveryServices/vaults/replicationFabrics@2024-04-01' = {
  name: 'acctest-fabric1-250703130022502990'
  parent: vault
  properties: {
    customDetails: {
      instanceType: 'Azure'
      location: 'westeurope'
    }
  }
}

resource replicationfabric1 'Microsoft.RecoveryServices/vaults/replicationFabrics@2024-04-01' = {
  name: 'acctest-fabric2b-250703130022502990'
  parent: vault
  properties: {
    customDetails: {
      instanceType: 'Azure'
      location: 'westus2'
    }
  }
}

resource replicationPolicy 'Microsoft.RecoveryServices/vaults/replicationPolicies@2024-04-01' = {
  name: 'acctest-policy-250703130022502990'
  parent: vault
  properties: {
    providerSpecificInput: {
      appConsistentFrequencyInMinutes: 240
      instanceType: 'A2A'
      multiVmSyncStatus: 'Enable'
      recoveryPointHistory: 1440
    }
  }
}

resource replicationProtectionContainer 'Microsoft.RecoveryServices/vaults/replicationFabrics/replicationProtectionContainers@2024-04-01' = {
  name: 'acctest-protection-cont1-250703130022502990'
  parent: replicationFabric
  properties: {}
}

resource replicationprotectioncontainer1 'Microsoft.RecoveryServices/vaults/replicationFabrics/replicationProtectionContainers@2024-04-01' = {
  name: 'acctest-protection-cont2-250703130022502990'
  parent: replicationfabric1
  properties: {}
}

resource replicationProtectionContainerMapping 'Microsoft.RecoveryServices/vaults/replicationFabrics/replicationProtectionContainers/replicationProtectionContainerMappings@2024-04-01' = {
  name: 'mapping-250703130022502990'
  parent: replicationProtectionContainer
  properties: {
    policyId: replicationPolicy.id
    providerSpecificInput: {
      instanceType: 'A2A'
    }
    targetProtectionContainerId: replicationprotectioncontainer1.id
  }
}
