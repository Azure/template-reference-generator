param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource iotHub 'Microsoft.Devices/IotHubs@2022-04-30-preview' = {
  name: resourceName
  location: location
  sku: {
    name: 'S1'
    capacity: 1
  }
  properties: {
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
    cloudToDevice: {}
  }
}

resource streamingJob 'Microsoft.StreamAnalytics/streamingJobs@2020-03-01' = {
  name: resourceName
  location: location
  properties: {
    cluster: {}
    eventsOutOfOrderPolicy: 'Adjust'
    outputErrorPolicy: 'Drop'
    compatibilityLevel: '1.0'
    contentStoragePolicy: 'SystemAccount'
    dataLocale: 'en-GB'
    eventsLateArrivalMaxDelayInSeconds: 60
    eventsOutOfOrderMaxDelayInSeconds: 50
    jobType: 'Cloud'
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
  name: resourceName
  parent: streamingJob
  properties: {
    datasource: {
      properties: {
        consumerGroupName: '$Default'
        endpoint: 'messages/events'
        iotHubNamespace: iotHub.name
        sharedAccessPolicyKey: iotHub.listKeys().value[0].primaryKey
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
