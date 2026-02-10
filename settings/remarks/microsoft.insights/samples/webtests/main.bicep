param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: resourceName
  location: location
  kind: 'web'
  properties: {
    DisableIpMasking: false
    DisableLocalAuth: false
    ForceCustomerStorageForProfiler: false
    RetentionInDays: 90
    SamplingPercentage: 100
    publicNetworkAccessForIngestion: 'Enabled'
    Application_Type: 'web'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

resource webTest 'Microsoft.Insights/webTests@2022-06-15' = {
  name: resourceName
  location: location
  kind: 'standard'
  properties: {
    RetryEnabled: false
    SyntheticMonitorId: resourceName
    Enabled: false
    Frequency: 300
    Kind: 'standard'
    Name: resourceName
    Request: {
      FollowRedirects: false
      Headers: [
        {
          value: 'testheader'
          key: 'x-header'
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
    Timeout: 30
    ValidationRules: {
      ExpectedHttpStatusCode: 200
      SSLCheck: false
    }
    Description: ''
    Locations: [
      {
        Id: 'us-tx-sn1-azr'
      }
    ]
  }
  tags: {
    'hidden-link:${component.id}': 'Resource'
  }
}
