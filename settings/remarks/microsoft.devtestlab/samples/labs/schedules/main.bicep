param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource lab 'Microsoft.DevTestLab/labs@2018-09-15' = {
  name: resourceName
  location: location
  properties: {
    labStorageType: 'Premium'
  }
}

resource schedule 'Microsoft.DevTestLab/labs/schedules@2018-09-15' = {
  parent: lab
  name: 'LabVmsShutdown'
  location: location
  properties: {
    dailyRecurrence: {
      time: '0100'
    }
    notificationSettings: {
      status: 'Disabled'
      timeInMinutes: 0
      webhookUrl: ''
    }
    status: 'Disabled'
    taskType: 'LabVmsShutdownTask'
    timeZoneId: 'India Standard Time'
  }
  tags: {
    environment: 'Production'
  }
}
