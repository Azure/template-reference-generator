param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource capacity 'Microsoft.PowerBIDedicated/capacities@2021-01-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'A1'
  }
  properties: {
    administration: {
      members: [
        deployer().objectId
      ]
    }
    mode: 'Gen2'
  }
}
