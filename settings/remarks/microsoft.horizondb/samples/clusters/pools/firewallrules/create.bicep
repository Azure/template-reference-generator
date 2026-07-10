@description('The name for the cluster')
param clusterName string
@description('The name for the pool')
param poolName string = 'DefaultPool'
@description('The name for the firewall rule')
param firewallRuleName string = 'DataAnalyticsDepartment'
@description('The start IP address for the firewall rule')
param firewallRuleStartIp string = '10.0.0.1'
@description('The end IP address for the firewall rule')
param firewallRuleEndIp string = '10.0.0.10'
@description('The description for the firewall rule')
param firewallRuleDescription string = 'Allow all IP addresses from the Data Analytics department'
@description('The create mode for cluster')
param createMode string = 'Create'
@description('The major version of server')
param version int = 17
@description('The administrator login name for cluster')
param administratorLogin string
@secure()
@description('The administrator login password for cluster')
param administratorLoginPassword string
@description('The number of vCores for each replica of the cluster')
param vCores int = 4
@description('The number of replicas for the cluster, including the primary replica, which is the only one in which writes are allowed. The other replicas are read-only.')
param replicaCount int = 2
@description('The name of the SKU for cluster')
param zonePlacementPolicy string = 'BestEffort'
resource flexibleServer 'Microsoft.HorizonDB/clusters/pools/firewallRules@2026-01-20-preview' = {
  name: '${clusterName}/${poolName}/${firewallRuleName}'
  properties: {
    startIp: firewallRuleStartIp
    endIp: firewallRuleEndIp
    description: firewallRuleDescription
  }
}
