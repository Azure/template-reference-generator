param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource disk 'Microsoft.Compute/disks@2022-03-02' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    creationData: {
      createOption: 'Empty'
    }
    diskSizeGB: 10
    encryption: {
      type: 'EncryptionAtRestWithPlatformKey'
    }
    networkAccessPolicy: 'AllowAll'
    osType: ''
    publicNetworkAccess: 'Enabled'
  }
}
