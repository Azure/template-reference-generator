param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource resourceGuard 'Microsoft.DataProtection/resourceGuards@2022-04-01' = {
  name: resourceName
  location: location
  properties: {
    vaultCriticalOperationExclusionList: []
  }
}
