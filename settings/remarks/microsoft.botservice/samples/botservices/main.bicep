param resourceName string = 'acctest0001'

resource botService 'Microsoft.BotService/botServices@2021-05-01-preview' = {
  name: resourceName
  location: 'global'
  kind: 'sdk'
  properties: {
    developerAppInsightKey: ''
    developerAppInsightsApiKey: ''
    developerAppInsightsApplicationId: ''
    displayName: 'acctest0001'
    endpoint: ''
    luisAppIds: []
    luisKey: ''
    msaAppId: deployer().objectId
  }
  sku: {
    name: 'F0'
  }
  tags: {
    environment: 'production'
  }
}
