param resourceName string = 'acctest0001'
param location string = 'eastus'

resource mobileNetwork 'Microsoft.MobileNetwork/mobileNetworks@2022-11-01' = {
  name: resourceName
  location: location
  properties: {
    publicLandMobileNetworkIdentifier: {
      mcc: '001'
      mnc: '01'
    }
  }
}

resource slice 'Microsoft.MobileNetwork/mobileNetworks/slices@2022-11-01' = {
  parent: mobileNetwork
  name: resourceName
  location: location
  properties: {
    snssai: {
      sst: 1
    }
  }
}
