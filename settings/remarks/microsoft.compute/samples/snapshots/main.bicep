param resourceName string = 'acctest0001'
param location string = 'westus'

resource disk 'Microsoft.Compute/disks@2023-04-02' = {
  name: '${resourceName}disk'
  location: location
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
  sku: {
    name: 'Standard_LRS'
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
