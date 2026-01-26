param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource queryPack 'Microsoft.OperationalInsights/queryPacks@2019-09-01' = {
  name: resourceName
  location: location
  properties: {}
}

resource query 'Microsoft.OperationalInsights/queryPacks/queries@2019-09-01' = {
  parent: queryPack
  name: 'aca50e92-d3e6-8f7d-1f70-2ec7adc1a926'
  properties: {
    body: '''    let newExceptionsTimeRange = 1d;
    let timeRangeToCheckBefore = 7d;
    exceptions
    | where timestamp < ago(timeRangeToCheckBefore)
    | summarize count() by problemId
    | join kind= rightanti (
        exceptions
        | where timestamp >= ago(newExceptionsTimeRange)
        | extend stack = tostring(details[0].rawStack)
        | summarize count(), dcount(user_AuthenticatedId), min(timestamp), max(timestamp), any(stack) by problemId
    ) on problemId
    | order by count_ desc
'''
    displayName: 'Exceptions - New in the last 24 hours'
    related: {}
  }
}
