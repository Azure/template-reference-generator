param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource capacity 'Microsoft.PowerBIDedicated/capacities@2021-01-01' = {
  name: resourceName
  location: location
  properties: {
    administration: {
      members: [
        deployer().objectId
      ]
    }
    mode: 'Gen2'
  }
  sku: {
    name: 'A1'
  }
}
