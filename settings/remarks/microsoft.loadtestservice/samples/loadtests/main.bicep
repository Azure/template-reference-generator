param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource loadTest 'Microsoft.LoadTestService/loadTests@2022-12-01' = {
  name: resourceName
  location: location
  properties: {
    description: 'This is new load test'
  }
}
