param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource streamingJob 'Microsoft.StreamAnalytics/streamingJobs@2020-03-01' = {
  name: resourceName
  location: location
  properties: {
    transformation: {
      name: 'main'
      properties: {
        query: '''   SELECT *
   INTO [YourOutputAlias]
   FROM [YourInputAlias]
'''
        streamingUnits: 3
      }
    }
    cluster: {}
    contentStoragePolicy: 'SystemAccount'
    eventsLateArrivalMaxDelayInSeconds: 60
    eventsOutOfOrderMaxDelayInSeconds: 50
    eventsOutOfOrderPolicy: 'Adjust'
    jobType: 'Cloud'
    outputErrorPolicy: 'Drop'
    sku: {
      name: 'Standard'
    }
    compatibilityLevel: '1.0'
    dataLocale: 'en-GB'
  }
}
