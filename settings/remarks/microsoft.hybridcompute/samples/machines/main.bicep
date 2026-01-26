param resourceName string = 'acctest0001'
param location string = 'westus'

resource machine 'Microsoft.HybridCompute/machines@2024-07-10' = {
  name: '${resourceName}hcm'
  location: location
  kind: 'SCVMM'
}
