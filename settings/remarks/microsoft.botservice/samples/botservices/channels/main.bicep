param resourceName string = 'acctest0001'
param location string = 'westus'

resource botService 'Microsoft.BotService/botServices@2021-05-01-preview' = {
  name: resourceName
  location: location
  sku: {
    name: 'F0'
  }
  kind: 'bot'
  properties: {
    developerAppInsightsApplicationId: ''
    displayName: '${resourceName}'
    isStreamingSupported: false
    msaAppId: '12345678-1234-1234-1234-123456789012'
    cmekKeyVaultUrl: ''
    description: ''
    developerAppInsightKey: ''
    developerAppInsightsApiKey: ''
    endpoint: ''
    iconUrl: 'https://docs.botframework.com/static/devportal/client/images/bot-framework-default.png'
    isCmekEnabled: false
  }
}

resource channel 'Microsoft.BotService/botServices/channels@2021-05-01-preview' = {
  name: 'AlexaChannel'
  location: location
  parent: botService
  kind: 'bot'
  properties: {
    channelName: 'AlexaChannel'
    properties: {
      alexaSkillId: 'amzn1.ask.skill.19126e57-867f-4553-b953-ad0a720dddec'
      isEnabled: true
    }
  }
}
