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
      standardTierStorageRedundancy: 'GeoRedundant'
      crossRegionRestore: 'Disabled'
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
      location: 'westus2'
      instanceType: 'Azure'
    }
  }
}

resource replicationPolicy 'Microsoft.RecoveryServices/vaults/replicationPolicies@2024-04-01' = {
  name: 'acctest-policy-250703130022502990'
  parent: vault
  properties: {
    providerSpecificInput: {
      instanceType: 'A2A'
      multiVmSyncStatus: 'Enable'
      recoveryPointHistory: 1440
      appConsistentFrequencyInMinutes: 240
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
