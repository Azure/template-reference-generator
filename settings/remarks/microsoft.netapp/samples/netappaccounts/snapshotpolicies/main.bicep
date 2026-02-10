param resourceName string = 'acctest0001'
param location string = 'eastus2'

resource netAppAccount 'Microsoft.NetApp/netAppAccounts@2022-05-01' = {
  name: resourceName
  location: location
  properties: {
    activeDirectories: []
  }
}

resource snapshotPolicy 'Microsoft.NetApp/netAppAccounts/snapshotPolicies@2022-05-01' = {
  name: resourceName
  location: location
  parent: netAppAccount
  properties: {
    hourlySchedule: {
      minute: 15
      snapshotsToKeep: 1
    }
    monthlySchedule: {
      daysOfMonth: '30,15,1'
      hour: 5
      minute: 0
      snapshotsToKeep: 1
    }
    weeklySchedule: {
      hour: 23
      minute: 0
      snapshotsToKeep: 1
      day: 'Monday,Friday'
    }
    dailySchedule: {
      hour: 22
      minute: 15
      snapshotsToKeep: 1
    }
    enabled: true
  }
}
