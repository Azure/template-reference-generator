param location string = 'westus'
param resourceName string = 'acctest0001'

resource elasticSan 'Microsoft.ElasticSan/elasticSans@2023-01-01' = {
  name: resourceName
  location: location
  properties: {
    baseSizeTiB: 1
    extendedCapacitySizeTiB: 0
    sku: {
      name: 'Premium_LRS'
      tier: 'Premium'
    }
  }
}
