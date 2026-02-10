param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource workbook 'Microsoft.Insights/workbooks@2022-04-01' = {
  name: 'be1ad266-d329-4454-b693-8287e4d3b35d'
  location: location
  kind: 'shared'
  properties: {
    category: 'workbook'
    displayName: 'acctest-amw-230630032616547405'
    serializedData: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
    sourceId: 'azure monitor'
  }
}
