param resourceName string = 'acctest0001'

resource systemTopic 'Microsoft.EventGrid/systemTopics@2021-12-01' = {
  name: resourceName
  location: 'global'
  properties: {
    source: resourceGroup().id
    topicType: 'Microsoft.Resources.ResourceGroups'
  }
}
