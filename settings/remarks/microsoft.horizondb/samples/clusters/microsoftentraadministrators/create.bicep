@description('The name of the HorizonDB cluster')
param clusterName string = 'example-cluster'
@description('The object ID of the Microsoft Entra administrator')
param objectId string = '11111111-1111-1111-1111-111111111111'

resource horizonDbResource 'Microsoft.HorizonDb/clusters/microsoftEntraAdministrators@2026-10-01-preview' = {
  name: '${clusterName}/${objectId}'
  properties: {
    principalName: 'database.administrators@contoso.com'
    principalType: 'Group'
    tenantId: '22222222-2222-2222-2222-222222222222'
  }
}
