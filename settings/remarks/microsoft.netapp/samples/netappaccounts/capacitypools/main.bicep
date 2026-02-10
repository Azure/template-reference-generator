param resourceName string = 'acctest0001'
param location string = 'centralus'

resource netAppAccount 'Microsoft.NetApp/netAppAccounts@2022-05-01' = {
  name: resourceName
  location: location
  properties: {
    activeDirectories: []
  }
  tags: {
    SkipASMAzSecPack: 'true'
  }
}

resource capacityPool 'Microsoft.NetApp/netAppAccounts/capacityPools@2022-05-01' = {
  name: resourceName
  location: location
  parent: netAppAccount
  properties: {
    size: 4398046511104
    serviceLevel: 'Standard'
  }
  tags: {
    SkipASMAzSecPack: 'true'
  }
}
