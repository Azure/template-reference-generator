param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource iothub 'Microsoft.Devices/IotHubs@2022-04-30-preview' = {
  name: resourceName
  location: location
  properties: {
    cloudToDevice: {}
    enableFileUploadNotifications: false
    messagingEndpoints: {}
    routing: {
      fallbackRoute: {
        condition: 'true'
        endpointNames: [
          'events'
        ]
        isEnabled: true
        source: 'DeviceMessages'
      }
    }
    storageEndpoints: {}
  }
  sku: {
    capacity: 1
    name: 'S1'
  }
}

resource streamingJob 'Microsoft.StreamAnalytics/streamingJobs@2020-03-01' = {
  name: resourceName
  location: location
  properties: {
    cluster: {}
    compatibilityLevel: '1.0'
    contentStoragePolicy: 'SystemAccount'
    dataLocale: 'en-GB'
    eventsLateArrivalMaxDelayInSeconds: 60
    eventsOutOfOrderMaxDelayInSeconds: 50
    eventsOutOfOrderPolicy: 'Adjust'
    jobType: 'Cloud'
    outputErrorPolicy: 'Drop'
    sku: {
      name: 'Standard'
    }
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
  }
}

resource input 'Microsoft.StreamAnalytics/streamingJobs/inputs@2020-03-01' = {
  parent: streamingJob
  name: resourceName
  properties: {
    datasource: {
      properties: {
        consumerGroupName: '$Default'
        endpoint: 'messages/events'
        iotHubNamespace: iothub.name
        sharedAccessPolicyKey: iothub.listkeys().value[0].primaryKey
        sharedAccessPolicyName: 'iothubowner'
      }
      type: 'Microsoft.Devices/IotHubs'
    }
    serialization: {
      properties: {}
      type: 'Avro'
    }
    type: 'Stream'
  }
}
