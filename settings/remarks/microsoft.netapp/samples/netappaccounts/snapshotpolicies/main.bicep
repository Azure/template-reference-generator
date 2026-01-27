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
  parent: netAppAccount
  name: resourceName
  location: location
  properties: {
    dailySchedule: {
      hour: 22
      minute: 15
      snapshotsToKeep: 1
    }
    enabled: true
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
      day: 'Monday,Friday'
      hour: 23
      minute: 0
      snapshotsToKeep: 1
    }
  }
}
