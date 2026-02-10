param recommendationId string
param resourceName string = 'acctest0001'
param location string = 'westus'

resource suppression 'Microsoft.Advisor/recommendations/suppressions@2023-01-01' = {
  name: resourceName
  properties: {
    suppressionId: ''
    ttl: '00:30:00'
  }
}
