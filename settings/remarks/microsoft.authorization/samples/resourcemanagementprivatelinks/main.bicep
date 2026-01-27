param resourceName string = 'acctest0001'
param location string = 'westus'

resource resourceManagementPrivateLink 'Microsoft.Authorization/resourceManagementPrivateLinks@2020-05-01' = {
  name: resourceName
  location: location
}
