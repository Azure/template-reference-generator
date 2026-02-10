param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource webTest 'Microsoft.Insights/webTests@2022-06-15' = {
  name: resourceName
  location: location
  kind: 'standard'
  properties: {
    Description: ''
    Enabled: false
    Name: resourceName
    Request: {
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
      FollowRedirects: false
    }
    SyntheticMonitorId: resourceName
    Timeout: 30
    Frequency: 300
    Kind: 'standard'
    Locations: [
      {
        Id: 'us-tx-sn1-azr'
      }
    ]
    RetryEnabled: false
    ValidationRules: {
      ExpectedHttpStatusCode: 200
      SSLCheck: false
    }
  }
  tags: {
    'hidden-link:${component.id}': 'Resource'
  }
}

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: resourceName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    ForceCustomerStorageForProfiler: false
    publicNetworkAccessForQuery: 'Enabled'
    DisableIpMasking: false
    DisableLocalAuth: false
    RetentionInDays: 90
    SamplingPercentage: 100
    publicNetworkAccessForIngestion: 'Enabled'
  }
}
