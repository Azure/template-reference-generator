param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: resourceName
  location: location
  properties: {
    destinations: {
      azureMonitorMetrics: {
        name: 'test-destination-metrics'
      }
    }
    dataFlows: [
      {
        destinations: [
          'test-destination-metrics'
        ]
        streams: [
          'Microsoft-InsightsMetrics'
        ]
      }
    ]
    description: ''
  }
}
