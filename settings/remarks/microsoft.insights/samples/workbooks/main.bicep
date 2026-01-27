param location string = 'westeurope'

resource workbook 'Microsoft.Insights/workbooks@2022-04-01' = {
  name: 'be1ad266-d329-4454-b693-8287e4d3b35d'
  location: location
  kind: 'shared'
  properties: {
    category: 'workbook'
    displayName: 'acctest-amw-230630032616547405'
    serializedData: '{"fallbackResourceIds":["Azure Monitor"],"isLocked":false,"items":[{"content":{"json":"Test2022"},"name":"text - 0","type":1}],"version":"Notebook/1.0"}'
    sourceId: 'azure monitor'
  }
}
