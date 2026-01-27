param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: resourceName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    DisableIpMasking: false
    DisableLocalAuth: false
    ForceCustomerStorageForProfiler: false
    RetentionInDays: 90
    SamplingPercentage: 100
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

resource webTest 'Microsoft.Insights/webTests@2022-06-15' = {
  name: resourceName
  location: location
  kind: 'standard'
  properties: {
    Description: ''
    Enabled: false
    Frequency: 300
    Kind: 'standard'
    Locations: [
      {
        Id: 'us-tx-sn1-azr'
      }
    ]
    Name: 'acctest0001'
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
    SyntheticMonitorId: 'acctest0001'
    Timeout: 30
    ValidationRules: {
      ExpectedHttpStatusCode: 200
      SSLCheck: false
    }
  }
  tags: {
    'hidden-link:azapi_resource.component.id': 'Resource'
  }
}
