targetScope = 'tenant'

param resourceName string = 'acctest0001'
param location string = 'eastus'
@secure()
@description('The GitHub access token for source control integration')
param githubToken string
@secure()
@description('The GitHub token secret for source control integration')
param githubTokenSecret string

resource sourcecontrol 'Microsoft.Web/sourcecontrols@2021-02-01' = {
  name: 'GitHub'
  properties: {
    token: '${githubToken}'
    tokenSecret: '${githubTokenSecret}'
  }
}
