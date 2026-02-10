param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource server 'Microsoft.AnalysisServices/servers@2017-08-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'B1'
  }
  properties: {
    ipV4FirewallSettings: {
      enablePowerBIService: false
      firewallRules: []
    }
    asAdministrators: {
      members: []
    }
  }
}
