param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource server 'Microsoft.AnalysisServices/servers@2017-08-01' = {
  name: resourceName
  location: location
  properties: {
    asAdministrators: {
      members: []
    }
    ipV4FirewallSettings: {
      enablePowerBIService: false
      firewallRules: []
    }
  }
  sku: {
    name: 'B1'
  }
}
