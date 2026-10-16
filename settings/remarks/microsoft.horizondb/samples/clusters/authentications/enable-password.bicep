@description('The name of the HorizonDB cluster')
param clusterName string = 'example-cluster'
@secure()
@description('The administrator login password')
param administratorLoginPassword string

resource horizonDbResource 'Microsoft.HorizonDb/clusters/authentications@2026-10-01-preview' = {
  name: '${clusterName}/passwordMethod'
  properties: {
    state: 'Enabled'
    administratorLogin: 'adminlogin1'
    administratorLoginPassword: administratorLoginPassword
  }
}
