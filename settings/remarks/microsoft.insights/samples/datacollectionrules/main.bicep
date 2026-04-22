param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: resourceName
  location: location
  properties: {
    dataFlows: [
      {
        streams: [
          'Microsoft-InsightsMetrics'
        ]
        destinations: [
          'test-destination-metrics'
        ]
      }
    ]
    description: ''
    destinations: {
      azureMonitorMetrics: {
        name: 'test-destination-metrics'
      }
    }
  }
}
