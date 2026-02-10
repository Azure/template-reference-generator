param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource workbookTemplate 'Microsoft.Insights/workbookTemplates@2020-11-20' = {
  name: resourceName
  location: location
  properties: {
    templateData: {
      styleSettings: {}
      version: 'Notebook/1.0'
      '$schema': 'https://github.com/Microsoft/Application-Insights-Workbooks/blob/master/schema/workbook.json'
      items: [
        {
          content: {
            json: '''## New workbook
---

Welcome to your new workbook.'''
          }
          name: 'text - 2'
          type: 1
        }
      ]
    }
    galleries: [
      {
        category: 'workbook'
        name: 'test'
        order: 0
        resourceType: 'Azure Monitor'
        type: 'workbook'
      }
    ]
    priority: 0
  }
}
