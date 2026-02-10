param resourceName string = 'acctest0001'
param location string = 'westeurope'

param clientId string

resource botService 'Microsoft.BotService/botServices@2021-05-01-preview' = {
  name: resourceName
  location: 'global'
  sku: {
    name: 'F0'
  }
  kind: 'sdk'
  properties: {
    msaAppId: clientId
    developerAppInsightKey: ''
    displayName: resourceName
    luisKey: ''
    developerAppInsightsApiKey: ''
    developerAppInsightsApplicationId: ''
    endpoint: ''
    luisAppIds: []
  }
  tags: {
    environment: 'production'
  }
}
