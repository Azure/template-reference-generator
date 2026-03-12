param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource streamingJob 'Microsoft.StreamAnalytics/streamingJobs@2020-03-01' = {
  name: resourceName
  location: location
  properties: {
    transformation: {
      name: 'main'
      properties: {
        query: '''    SELECT *
    INTO [YourOutputAlias]
    FROM [YourInputAlias]
'''
        streamingUnits: 3
      }
    }
    cluster: {}
    compatibilityLevel: '1.0'
    contentStoragePolicy: 'SystemAccount'
    eventsOutOfOrderMaxDelayInSeconds: 50
    outputErrorPolicy: 'Drop'
    dataLocale: 'en-GB'
    eventsLateArrivalMaxDelayInSeconds: 60
    eventsOutOfOrderPolicy: 'Adjust'
    jobType: 'Cloud'
    sku: {
      name: 'Standard'
    }
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
