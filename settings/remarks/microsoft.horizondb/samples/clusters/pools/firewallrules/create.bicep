@description('The name of the HorizonDB cluster')
param clusterName string = 'example-cluster'
@description('The name of the HorizonDB pool')
param poolName string = 'example-pool-01'
@description('The name of the firewall rule')
param firewallRuleName string = 'example-firewall-rule-01'

resource horizonDbResource 'Microsoft.HorizonDb/clusters/pools/firewallRules@2026-10-01-preview' = {
  name: '${clusterName}/${poolName}/${firewallRuleName}'
  properties: {
    startIpAddress: '10.0.0.1'
    endIpAddress: '10.0.0.254'
    description: 'Allow access from the corporate network'
  }
}
