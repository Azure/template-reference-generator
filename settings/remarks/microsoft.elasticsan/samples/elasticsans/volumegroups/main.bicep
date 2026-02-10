param resourceName string = 'acctest0001'
param location string = 'westus'

resource elasticSan 'Microsoft.ElasticSan/elasticSans@2023-01-01' = {
  name: '${resourceName}-es'
  location: location
  properties: {
    baseSizeTiB: 1
    extendedCapacitySizeTiB: 0
    sku: {
      tier: 'Premium'
      name: 'Premium_LRS'
    }
  }
}

resource volumeGroup 'Microsoft.ElasticSan/elasticSans/volumeGroups@2023-01-01' = {
  name: '${resourceName}-vg'
  parent: elasticSan
  properties: {
    encryption: 'EncryptionAtRestWithPlatformKey'
    networkAcls: {
      virtualNetworkRules: []
    }
    protocolType: 'Iscsi'
  }
}
