param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: resourceName
  location: location
  kind: 'web'
  properties: {
    SamplingPercentage: 100
    Application_Type: 'web'
    DisableIpMasking: false
    DisableLocalAuth: false
    ForceCustomerStorageForProfiler: false
    RetentionInDays: 90
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

resource webTest 'Microsoft.Insights/webTests@2022-06-15' = {
  name: resourceName
  location: location
  kind: 'standard'
  properties: {
    Enabled: false
    Kind: 'standard'
    Request: {
      FollowRedirects: false
      Headers: [
        {
          key: 'x-header'
          value: 'testheader'
        }
        {
          key: 'x-header-2'
          value: 'testheader2'
        }
      ]
      HttpVerb: 'GET'
      ParseDependentRequests: false
      RequestUrl: 'http://microsoft.com'
    }
    RetryEnabled: false
    SyntheticMonitorId: resourceName
    ValidationRules: {
      SSLCheck: false
      ExpectedHttpStatusCode: 200
    }
    Description: ''
    Frequency: 300
    Locations: [
      {
        Id: 'us-tx-sn1-azr'
      }
    ]
    Name: resourceName
    Timeout: 30
  }
  tags: {
    'hidden-link:${component.id}': 'Resource'
  }
}
