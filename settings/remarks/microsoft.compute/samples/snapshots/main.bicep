param resourceName string = 'acctest0001'
param location string = 'westus'

resource snapshot 'Microsoft.Compute/snapshots@2022-03-02' = {
  name: '${resourceName}snapshot'
  location: location
  properties: {
    creationData: {
      sourceUri: disk.id
      createOption: 'Copy'
    }
    diskSizeGB: 20
    incremental: false
    networkAccessPolicy: 'AllowAll'
    publicNetworkAccess: 'Enabled'
  }
}

resource disk 'Microsoft.Compute/disks@2023-04-02' = {
  name: '${resourceName}disk'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    diskSizeGB: 10
    encryption: {
      type: 'EncryptionAtRestWithPlatformKey'
    }
    networkAccessPolicy: 'AllowAll'
    optimizedForFrequentAttach: false
    publicNetworkAccess: 'Enabled'
    creationData: {
      performancePlus: false
      createOption: 'Empty'
    }
  }
}
