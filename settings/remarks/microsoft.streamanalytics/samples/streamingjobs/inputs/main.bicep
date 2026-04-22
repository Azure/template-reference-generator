param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource streamingJob 'Microsoft.StreamAnalytics/streamingJobs@2020-03-01' = {
  name: resourceName
  location: location
  properties: {
    cluster: {}
    compatibilityLevel: '1.0'
    dataLocale: 'en-GB'
    eventsLateArrivalMaxDelayInSeconds: 60
    eventsOutOfOrderMaxDelayInSeconds: 50
    eventsOutOfOrderPolicy: 'Adjust'
    outputErrorPolicy: 'Drop'
    sku: {
      name: 'Standard'
    }
    contentStoragePolicy: 'SystemAccount'
    jobType: 'Cloud'
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

resource iotHub 'Microsoft.Devices/IotHubs@2022-04-30-preview' = {
  name: resourceName
  location: location
  sku: {
    capacity: 1
    name: 'S1'
  }
  properties: {
    routing: {
      fallbackRoute: {
        endpointNames: [
          'events'
        ]
        isEnabled: true
        source: 'DeviceMessages'
        condition: 'true'
      }
    }
    storageEndpoints: {}
    cloudToDevice: {}
    enableFileUploadNotifications: false
    messagingEndpoints: {}
  }
}
