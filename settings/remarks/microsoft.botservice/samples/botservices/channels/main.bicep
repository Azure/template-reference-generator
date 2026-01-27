param resourceName string = 'acctest0001'
param location string = 'westus'

resource botService 'Microsoft.BotService/botServices@2021-05-01-preview' = {
  name: resourceName
  location: location
  kind: 'bot'
  properties: {
    cmekKeyVaultUrl: ''
    description: ''
    developerAppInsightKey: ''
    developerAppInsightsApiKey: ''
    developerAppInsightsApplicationId: ''
    displayName: 'acctest0001'
    endpoint: ''
    iconUrl: 'https://docs.botframework.com/static/devportal/client/images/bot-framework-default.png'
    isCmekEnabled: false
    isStreamingSupported: false
    msaAppId: '12345678-1234-1234-1234-123456789012'
  }
  sku: {
    name: 'F0'
  }
}

resource channel 'Microsoft.BotService/botServices/channels@2021-05-01-preview' = {
  parent: botService
  name: 'AlexaChannel'
  location: location
  kind: 'bot'
  properties: {
    channelName: 'AlexaChannel'
    properties: {
      alexaSkillId: 'amzn1.ask.skill.19126e57-867f-4553-b953-ad0a720dddec'
      isEnabled: true
    }
  }
}
