param location string = 'westus'
param resourceName string = 'acctest0001'

resource disk 'Microsoft.Compute/disks@2023-04-02' = {
  name: '${resourceName}disk'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    creationData: {
      createOption: 'Empty'
      performancePlus: false
    }
    diskSizeGB: 10
    encryption: {
      type: 'EncryptionAtRestWithPlatformKey'
    }
    networkAccessPolicy: 'AllowAll'
    optimizedForFrequentAttach: false
    publicNetworkAccess: 'Enabled'
  }
}

resource snapshot 'Microsoft.Compute/snapshots@2022-03-02' = {
  name: '${resourceName}snapshot'
  location: location
  properties: {
    creationData: {
      createOption: 'Copy'
      sourceUri: disk.id
    }
    diskSizeGB: 20
    incremental: false
    networkAccessPolicy: 'AllowAll'
    publicNetworkAccess: 'Enabled'
  }
}
