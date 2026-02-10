param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource disk 'Microsoft.Compute/disks@2022-03-02' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    osType: ''
    publicNetworkAccess: 'Enabled'
    creationData: {
      createOption: 'Empty'
    }
    diskSizeGB: 10
    encryption: {
      type: 'EncryptionAtRestWithPlatformKey'
    }
    networkAccessPolicy: 'AllowAll'
  }
}
