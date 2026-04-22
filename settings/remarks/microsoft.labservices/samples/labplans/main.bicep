param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource labPlan 'Microsoft.LabServices/labPlans@2022-08-01' = {
  name: resourceName
  location: location
  properties: {
    allowedRegions: [
      '${location}'
    ]
  }
}
