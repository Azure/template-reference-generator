param resourceName string = 'acctest0001'
param location string = 'eastus'

resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: '${resourceName}-uai'
  location: location
}

resource devCenter 'Microsoft.DevCenter/devCenters@2025-02-01' = {
  name: resourceName
  location: location
}
