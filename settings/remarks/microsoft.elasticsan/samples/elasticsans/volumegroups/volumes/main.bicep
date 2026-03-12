param resourceName string = 'acctest0001'
param location string = 'westus'

resource elasticSan 'Microsoft.ElasticSan/elasticSans@2023-01-01' = {
  name: '${resourceName}-es'
  location: location
  properties: {
    extendedCapacitySizeTiB: 0
    sku: {
      name: 'Premium_LRS'
      tier: 'Premium'
    }
    baseSizeTiB: 1
  }
}

resource volumeGroup 'Microsoft.ElasticSan/elasticSans/volumeGroups@2023-01-01' = {
  name: '${resourceName}-vg'
  parent: elasticSan
  properties: {
    protocolType: 'Iscsi'
    encryption: 'EncryptionAtRestWithPlatformKey'
    networkAcls: {
      virtualNetworkRules: []
    }
  }
}

resource volume 'Microsoft.ElasticSan/elasticSans/volumeGroups/volumes@2023-01-01' = {
  name: '${resourceName}-v'
  parent: volumeGroup
  properties: {
    sizeGiB: 1
  }
}
