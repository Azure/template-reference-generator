param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource iotHub 'Microsoft.Devices/IotHubs@2022-04-30-preview' = {
  name: resourceName
  location: location
  sku: {
    capacity: 1
    name: 'S1'
  }
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
}

resource streamingJob 'Microsoft.StreamAnalytics/streamingJobs@2020-03-01' = {
  name: resourceName
  location: location
  properties: {
    eventsOutOfOrderPolicy: 'Adjust'
    jobType: 'Cloud'
    outputErrorPolicy: 'Drop'
    sku: {
      name: 'Standard'
    }
    dataLocale: 'en-GB'
    eventsLateArrivalMaxDelayInSeconds: 60
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
    compatibilityLevel: '1.0'
    contentStoragePolicy: 'SystemAccount'
    eventsOutOfOrderMaxDelayInSeconds: 50
  }
}

resource input 'Microsoft.StreamAnalytics/streamingJobs/inputs@2020-03-01' = {
  name: resourceName
  parent: streamingJob
  properties: {
    type: 'Stream'
    datasource: {
      properties: {
        iotHubNamespace: iotHub.name
        sharedAccessPolicyKey: iotHub.listKeys().value[0].primaryKey
        sharedAccessPolicyName: 'iothubowner'
        consumerGroupName: '$Default'
        endpoint: 'messages/events'
      }
      type: 'Microsoft.Devices/IotHubs'
    }
    serialization: {
      properties: {}
      type: 'Avro'
    }
  }
}
