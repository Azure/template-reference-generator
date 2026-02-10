param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource streamingJob 'Microsoft.StreamAnalytics/streamingJobs@2020-03-01' = {
  name: resourceName
  location: location
  properties: {
    contentStoragePolicy: 'SystemAccount'
    dataLocale: 'en-GB'
    eventsLateArrivalMaxDelayInSeconds: 60
    sku: {
      name: 'Standard'
    }
    transformation: {
      properties: {
        query: '''    SELECT *
    INTO [YourOutputAlias]
    FROM [YourInputAlias]
'''
        streamingUnits: 3
      }
      name: 'main'
    }
    cluster: {}
    compatibilityLevel: '1.0'
    eventsOutOfOrderMaxDelayInSeconds: 50
    eventsOutOfOrderPolicy: 'Adjust'
    jobType: 'Cloud'
    outputErrorPolicy: 'Drop'
  }
}

resource function 'Microsoft.StreamAnalytics/streamingJobs/functions@2020-03-01' = {
  name: resourceName
  parent: streamingJob
  properties: {
    properties: {
      binding: {
        properties: {
          script: '''function getRandomNumber(in) {
  return in;
}
'''
        }
        type: 'Microsoft.StreamAnalytics/JavascriptUdf'
      }
      inputs: [
        {
          dataType: 'bigint'
          isConfigurationParameter: false
        }
      ]
      output: {
        dataType: 'bigint'
      }
    }
    type: 'Scalar'
  }
}
