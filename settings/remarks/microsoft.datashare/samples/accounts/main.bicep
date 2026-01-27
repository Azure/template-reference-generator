param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource account 'Microsoft.DataShare/accounts@2019-11-01' = {
  name: resourceName
  location: location
  tags: {
    env: 'Test'
  }
}
