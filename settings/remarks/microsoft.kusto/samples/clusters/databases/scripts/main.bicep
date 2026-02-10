param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource cluster 'Microsoft.Kusto/clusters@2023-05-02' = {
  name: resourceName
  location: location
  sku: {
    capacity: 1
    name: 'Dev(No SLA)_Standard_D11_v2'
    tier: 'Basic'
  }
  properties: {
    enableAutoStop: true
    enableDoubleEncryption: false
    enablePurge: false
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    enableDiskEncryption: false
    enableStreamingIngest: false
    engineType: 'V2'
    publicIPType: 'IPv4'
    trustedExternalTenants: []
  }
}

resource database 'Microsoft.Kusto/clusters/databases@2023-05-02' = {
  name: resourceName
  location: location
  parent: cluster
  kind: 'ReadWrite'
  properties: {}
}

resource script 'Microsoft.Kusto/clusters/databases/scripts@2023-05-02' = {
  name: 'create-table-script'
  parent: database
  properties: {
    continueOnErrors: false
    forceUpdateTag: '9e2e7874-aa37-7041-81b7-06397f03a37d'
    scriptContent: '''.create table TestTable(Id:string, Name:string, _ts:long, _timestamp:datetime)
.create table TestTable ingestion json mapping "TestMapping"
''[''
''    {"column":"Id","path":"$.id"},''
''    {"column":"Name","path":"$.name"},''
''    {"column":"_ts","path":"$._ts"},''
''    {"column":"_timestamp","path":"$._ts", "transform":"DateTimeFromUnixSeconds"}''
'']''
.alter table TestTable policy ingestionbatching "{''MaximumBatchingTimeSpan'': ''0:0:10'', ''MaximumNumberOfItems'': 10000}"
'''
  }
}
